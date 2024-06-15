# XPack RISC-V GCC package 

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/riscv_xpack_gcc_dev_env:latest`|
|*User* | `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/home/docker_user/.xpack/repos/@xpack-dev-tools/`|
|*Tool Path*| `/opt/riscv-none-embed` |

Docker environment for running the xpack riscv-none-elf-gcc release.

https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases

```bash
docker run \
    --tty \
    --interactive \
    --rm \
    -v .:/project \
    fiveembeddev/riscv_xpack_gcc_dev_env:latest \
    riscv-none-elf-gcc --version
```

```
riscv-none-elf-gcc (xPack GNU RISC-V Embedded GCC x86_64) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```
