# GNU Toolchain compiled from source

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/riscv_gnu_toolchain_dev_env2:latest`|
|*User* | `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/opt/riscv-toolchain/`|


Clone the https://github.com/riscv-collab/riscv-gnu-toolchain repo and
build the toolchain in this folder. The build files will be copied
into a docker container.

NOTE - The Makefile in this directory is not for convinence, it must
be used to build the image.

The final `fiveembeddev/riscv_gnu_toolchain_dev_env2` image will have
the `riscv32-unknown-elf-` toolchain on the path.

NOTE - The tool build requires 5GB+ of disk space. 

