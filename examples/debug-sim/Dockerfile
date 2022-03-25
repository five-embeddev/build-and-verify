FROM five_embeddev/riscv_xpack_gcc_dev_env:latest AS build_env 

WORKDIR /project/
RUN mkdir /project/build

# TODO - add something
RUN riscv-none-embed-gdb --version

# ------------------------------------------------------------------------

FROM build_env AS gdb_env

ENTRYPOINT ["riscv-none-embed-gdb","-ex","target remote 127.0.0.1:3333"]

# ------------------------------------------------------------------------
FROM five_embeddev/riscv_spike_dev_env:latest AS debug_env_base

WORKDIR /project/

# Merge in openocd
COPY --from=five_embeddev/riscv_openocd /opt/riscv-openocd/ /opt/riscv-openocd/

RUN sudo apt-get update -qq && sudo apt-get install -y ncat
ENV PATH=/opt/riscv-openocd/bin:/opt/riscv-isa-sim/bin:/bin:/usr/bin:/usr/local/bin

COPY riscv_spike.cfg /opt/

# ------------------------------------------------------------------------
FROM debug_env_base AS debug_env_sim

COPY sim_helpers.sh /opt/
COPY entrypoint.sh /opt/

ENTRYPOINT ["/opt/entrypoint.sh"]

# ------------------------------------------------------------------------
FROM debug_env_base  AS debug_env_sim_gdb

RUN sudo mkdir -p /opt/riscv-none-embed/bin/
COPY --from=five_embeddev/riscv_xpack_gcc_dev_env:latest \
	/opt/riscv-none-embed/bin/riscv-none-embed-gdb \
	/opt/riscv-none-embed/bin/libexpat.so.1 \
	/opt/riscv-none-embed/bin/libexpat.so.1.6.7 \
	/opt/riscv-none-embed/bin/libgcc_s.so.1 \
	/opt/riscv-none-embed/bin/libgmp.so.10 \
	/opt/riscv-none-embed/bin/libgmp.so.10.3.2 \
	/opt/riscv-none-embed/bin/libiconv.so.2 \
	/opt/riscv-none-embed/bin/libiconv.so.2.6.0 \
	/opt/riscv-none-embed/bin/liblzma.so.5 \
	/opt/riscv-none-embed/bin/liblzma.so.5.2.3 \
	/opt/riscv-none-embed/bin/libmpfr.so.4 \
	/opt/riscv-none-embed/bin/libmpfr.so.4.1.6 \
	/opt/riscv-none-embed/bin/libncurses.so.6 \
	/opt/riscv-none-embed/bin/libncurses.so.6.2 \
	/opt/riscv-none-embed/bin/libstdc++.so.6 \
	/opt/riscv-none-embed/bin/libstdc++.so.6.0.28 \
	/opt/riscv-none-embed/bin/libz.so.1 \
	/opt/riscv-none-embed/bin/libz.so.1.2.8 \
	/opt/riscv-none-embed/bin/

ENV PATH=/opt/riscv-none-embed/bin:${PATH}
RUN riscv-none-embed-gdb --version

COPY sim_helpers.sh /opt/
COPY entrypoint_gdb.sh /opt/

ENTRYPOINT ["/opt/entrypoint_gdb.sh"]
