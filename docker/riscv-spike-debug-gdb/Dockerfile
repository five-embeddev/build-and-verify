ARG SPIKE_IMAGE_NAME=riscv_spike_dev_env
FROM fiveembeddev/${SPIKE_IMAGE_NAME}:latest AS riscv_spike_debug_gdb

WORKDIR /project/

# Merge in openocd
COPY --from=fiveembeddev/riscv_openocd_base:latest \
     /opt/riscv-openocd/ \
     /opt/riscv-openocd/

RUN sudo mkdir -p /opt/riscv-none-embed/bin

COPY --from=fiveembeddev/riscv_xpack_gcc_dev_env:latest \
    /opt/riscv-none-embed/bin/riscv-none-elf-gdb \
    /opt/riscv-none-embed/bin/

COPY --from=fiveembeddev/riscv_xpack_gcc_dev_env:latest \
    /opt/riscv-none-embed/libexec \
    /opt/riscv-none-embed/libexec

COPY --from=fiveembeddev/riscv_xpack_gcc_dev_env:latest \
    /opt/riscv-none-embed/include \
    /opt/riscv-none-embed/include

ENV PATH=/opt/riscv-none-embed/bin:${PATH}
RUN /opt/riscv-none-embed/bin/riscv-none-elf-gdb --version

RUN sudo apt-get update -qq && sudo apt-get install -y ncat
ENV PATH=/opt/riscv-openocd/bin:/opt/riscv-isa-sim/bin:/bin:/usr/bin:/usr/local/bin:/opt/riscv-none-embed/bin/

COPY riscv_spike.cfg /opt/
COPY sim_helpers.sh /opt/
COPY entrypoint_gdb.sh /opt/
RUN sudo chmod +x /opt/entrypoint_gdb.sh

ENV RISCV_ISA=rv32imac
ENV RISCV_PRIV=m
ENV BOARD_MEM=0x8000000:0x2000,0x80000000:0x4000,0x20010000:0x6a120
ENV START_PC=0x20010000

ENTRYPOINT ["/opt/entrypoint_gdb.sh"]
