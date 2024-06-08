Docker environment for running spike with openocd for exposing a GDB
port for debugging RISC-V applications.

## Standard Version

## VCD Version

VCD Trace can saved to inspect a run.

~~~
docker run \
    -it \
    --rm \
    -v .:/project \
    fiveembeddev/forked_riscv_spike_debug_sim:latest  \
    --vcd-log=test.vcd \
    --max-cycles=10000  \
    build_target/src/main.elf
~~~
