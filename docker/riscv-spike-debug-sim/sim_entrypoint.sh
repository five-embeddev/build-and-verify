#!/bin/bash
# USAGE: ./entrypoint.sh <args to spike>

source /opt/sim_helpers.sh

# ------------------------------------------
# Setup 

trap clean_up SIGHUP SIGINT SIGTERM

# ------------------------------------------
# Print args

echo "SPIKE: STARTING with ARGS: $@"
ELF=$(find_elf_args $@)
echo "FOUND ELF: ${ELF}"

if [ "${ELF}" == "" ] ; then
    echo "NO ELF FILE FOUND: ${ELF}"
fi

# ------------------------------------------
# Start sim

nohup \
    /opt/riscv-isa-sim/bin/spike \
    --rbb-port=${BITBANG_PORT} \
    -H \
	--isa=${RISCV_ISA} \
	--priv=${RISCV_PRIV} \
	-m${BOARD_MEM}  \
	--pc=${START_PC} \
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

echo "OPENOCD: READY, GDB: ${GDB_PORT}, COMMAND: ${CMD_PORT}"

while [ 1 ] ; do
    sleep 0.1 ;
    test_alive "SPIKE" $SPIKE_PID
    test_alive "OPENOCD" $OPENOCD_PID
done


# will not reach here.
