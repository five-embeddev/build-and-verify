Clone the https://github.com/riscv-collab/riscv-gnu-toolchain repo and
build the toolchain within Docker. A multistage docker file is used to
reduce the size of the final image.

The final fiveembeddev/riscv_gnu_toolchain_dev_env image will have
the riscv32-unknown-elf- toolchain on the path.


NOTE - The tool build requires 5GB+ of disk space, and building within
docker requires a lot of system resources. An alternate build is in
../riscv-gnu-toolchain-2/.

