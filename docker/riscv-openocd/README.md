Clone and build the riscv port of openocd from
https://github.com/riscv/riscv-openocd. The tools will be built inside
of the docker image. A multistage docker file is used so the source is
not included in the final image.

An example configuration file is copied into the docker image for
running with the spike ISA simulator.
