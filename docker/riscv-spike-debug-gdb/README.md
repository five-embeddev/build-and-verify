# Debug Server With RISC-V Spike

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/riscv_spike_debug_gdb:latest`|
|*User*| `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/opt/riscv-isa-sim/`|
|*Tool Path*| `/opt/riscv-openocd/`|
|*Tool Path*| `/opt/riscv-none-embed/`|

Docker environment for running spike with openocd & GDB to allow direct debugging RISC-V applications.

~~~
docker run \
    -it \
    --rm \
    -v .:/project \
    fiveembeddev/riscv_spike_debug_gdb:latest  \
    build/main.elf
~~~

output:

~~~
SPIKE: STARTING with ARGS: build/main.elf
FOUND ELF: build/main.elf
SPIKE: WAIT FOR PORT 9824
SPIKE: READY
OPENOCD: STARTING
OPENOCD: READY
GDB: LOAD: build/main.elf
GNU gdb (xPack GNU RISC-V Embedded GCC x86_64) 12.1

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from build/main.elf...
Remote debugging using 127.0.0.1:3333
0x00001000 in ?? ()
(gdb) tui enable
Detaching from program: /project/build/main.elf, Remote target
Ending remote debugging.
[Inferior 1 (Remote target) detached]
~~~
