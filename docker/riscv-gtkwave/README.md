# Container for running GTKWave with decoders.

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/riscv_gtkwave_base:latest`|
|*User*| `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/opt/riscv-gtkwave/`|

Following tools installed:
- [GTKWave](https://gtkwave.sourceforge.net/)
- [RISC-V GTKWave Decoders](https://gtkwave.sourceforge.net/)

GTKWave is an x11 app, expose X11 env.

```bash
docker run \
    --tty \
    --interactive \
    --rm \
     -v .:/project \
     -v /tmp/.X11-unix:/tmp/.X11-unix \
     -e DISPLAY=:0 \
     fiveembeddev/riscv_gtkwave_base:latest \
     gtkwave vcd-trace.vcd config.gtkw
```

Decode elf address:

``` bash
docker run \
    --tty \
    --interactive \
    --rm \
    -v .:/project \
    -eDECODE_ELF=build_target/src/main.elf \ 
    fiveembeddev/riscv_gtkwave_base:latest
    /opt/riscv_gtkwave/bin/decode_addr
0x21000000
__clz_tab+0xfeffec
```


Decode risc-v opcode:

``` bash
docker run \
    --tty \
    --interactive \
    --rm \
    fiveembeddev/riscv_gtkwave_base:latest
    /opt/riscv_gtkwave/bin/decode_inst-rv32imac
0
c.unimp
```

