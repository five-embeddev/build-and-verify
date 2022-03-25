#!/bin/bash
# USAGE: ./entrypoint.sh <args to spike>

source /opt/sim_helpers.sh

# ------------------------------------------
# Setup 

trap clean_up SIGHUP SIGINT SIGTERM

# ------------------------------------------
# Print args

echo "SPIKE: STARTING with ARGS: $@"

ELF_FILE=$(find_elf_args $@)
echo "FOUND ELF: ${ELF_FILE}"

# ------------------------------------------
# Start sim

nohup \
    /opt/riscv-isa-sim/bin/spike \
    --rbb-port=${BITBANG_PORT} \
    -H \
    "$@" \
    > ${LOG_DIR}/spike.log 2>&1 & echo $! > ${PID_DIR}/spike.pid

if [ -f ${PID_DIR}/spike.pid ] ; then
    SPIKE_PID=`cat ${PID_DIR}/spike.pid`
fi
      
echo "SPIKE: WAIT FOR PORT ${BITBANG_PORT}"

waitport "SPIKE" ${SPIKE_PID}  ${BITBANG_PORT} 

echo "SPIKE: READY"

# ------------------------------------------
# Start openocd

echo "OPENOCD: STARTING"

nohup \
    /opt/riscv-openocd/bin/openocd \
    -f /opt/riscv_spike.cfg \
    > ${LOG_DIR}/openocd.log 2>&1 & echo $! > ${PID_DIR}/openocd.pid

if [ -f ${PID_DIR}/openocd.pid ] ; then
    OPENOCD_PID=`cat ${PID_DIR}/openocd.pid`
fi

waitport "OPENOCD" ${OPENOCD_PID} ${CMD_PORT} 

# ------------------------------------------
# Wait for exit

echo "OPENOCD: READY"
echo "GDB: LOAD: ${ELF_FILE}"

riscv-none-embed-gdb -ex 'target remote 127.0.0.1:3333' ${ELF_FILE}

