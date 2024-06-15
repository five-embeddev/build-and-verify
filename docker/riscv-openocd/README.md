# OpenOCD for RISC-V

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/riscv_openocd_base:latest`|
|*User*| `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/opt/riscv-openocd/`|


Clone and build the RISC-V port of openocd from
https://github.com/riscv-collab/riscv-openocd. The tools will be built inside
of the docker image. A multistage docker file is used so the source is
not included in the final image.

An example configuration file is copied into the docker image for
running with the spike ISA simulator.

```bash
docker run \
    --tty \
    --interactive \
    --rm \
     -v .:/project \
     -p "9824:9824" \
     -p "4000:4000" \
     -p "6000:6000" \
     -p "3000:3000" \
     fiveembeddev/riscv_openocd_base:latest \
    /opt/riscv-openocd/bin/openocd \
    -f /opt/riscv-openocd/riscv_spike.cfg 
```

(Note: command requires a target to connect to on 9824, such as riscv-spike)
