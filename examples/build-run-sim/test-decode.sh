#! /bin/bash

echo "DECODE_ELF=${DECODE_ELF}"
grep 0x build/main.map  | \
    perl -p -e 's/^.*(0x[0-9A-Fa-f]{8,16}).*$/$1/'  | \
    cut -f1 -d' ' |  \
    sort -u > test.addr
cat test.addr
/opt/riscv-gtkwave/bin/decode_addr  < test.addr
