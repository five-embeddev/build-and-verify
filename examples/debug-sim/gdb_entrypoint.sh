#!/bin/bash
# USAGE: ./entrypoint.sh <args to spike>

BITBANG_PORT=9824

ls -l /work/build/main.elf
echo spike /opt/riscv-isa-sim/bin/spike --rbb-port=${BITBANG_PORT} "$@" /work/build/main.elf
spike /opt/riscv-isa-sim/bin/spike --rbb-port=${BITBANG_PORT} "$@" /work/build/main.elf
screen -c screen.conf -dmS spike /opt/riscv-isa-sim/bin/spike --rbb-port=${BITBANG_PORT} "$@" /work/build/main.elf

 
sleep 1

ps aux

cat spike.log

openocd -f spike.cfg

