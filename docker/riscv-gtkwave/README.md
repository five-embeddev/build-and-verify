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
