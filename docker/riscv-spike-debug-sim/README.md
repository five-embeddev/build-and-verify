# Debug Server With RISC-V Spike

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/riscv_spike_debug_sim:latest`|
|*Image*|`fiveembeddev/forked_riscv_spike_debug_sim:latest`|
|*User*| `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/opt/riscv-isa-sim/`|
|*Tool Path*| `/opt/riscv-openocd/`|
|*GDB Port*| 3333 |
|*OpenOCD TCL Port*| 6666 |
|*OpenOCD CMD Port*| 4444 |

Docker environment for running spike with openocd for exposing a GDB
port for debugging RISC-V applications.

## Standard Version

Expose a server for GDB.

~~~
docker run \
    -it \
    -p 3333:3333
    --rm \
    -v .:/project \
    fiveembeddev/riscv_spike_debug_sim:latest  \
    build_target/src/main.elf
~~~


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
