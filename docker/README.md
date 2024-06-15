# Docker for emebdded RISC-V development.

| Target                | Description |
|-----------------------|-------------|
| riscv-tool-build      | Base image for compiling tools|
| riscv-spike           | RISC-V ISA Simulator. |
| riscv-openocd         | OpenOCD JTAG debugger interface| 
| riscv-xpack-gcc       | X-PACK packaged GCC |
| riscv-spike-debug-sim | RISC-V Spike ISA configured to run with OpenOCD|
| riscv-spike-debug-gdb | RISC-V Spike ISA configured to run with OpenOCD & GDB|
| riscv-rust            | Rust for RISC-V |
| riscv-gnu-toolchain   | Build GCC for RISC-V |
| riscv-gnu-toolchain-2 | Build GCC for RISC-V (using docker compose to conserve resources) |

Each Docker environment is configured to run with a `docker_user` account and user `/project/` as the working directory.


