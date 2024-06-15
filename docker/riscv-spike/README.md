# Docker container for running the RISC-V spike ISA simulator.

The source will be downloaded and compiled within the docker container.

## Standard Version

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/riscv_spike_dev_env:latest`|
|*User*| `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/opt/riscv-isa-sim/`|

RISC-V reference ISA simulator, Spike.

```bash
docker run \
    --tty \
    --interactive \
    --rm \
    -v .:/project \
     fiveembeddev/riscv_spike_dev_env:latest \
    spike --help
```

## Forked Version with VCD Tracing and command file extensions

Compiled from my fork with VCD tracing https://github.com/five-embeddev/riscv-isa-sim/tree/vcd_trace

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/forked_riscv_spike_dev_env:latest`|
|*User*| `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/opt/riscv-isa-sim/`|

```bash
docker run \
    --tty \
    --interactive \
    --rm \
    -v .:/project \
     fiveembeddev/forked_riscv_spike_dev_env:latest \
    spike --help
```

Note the new options

```
  --vcd-log=<file>      Log VCD to this file.
  --max-cycles=<cycle count>      Limit simulation to this number of cycles.
  ```
