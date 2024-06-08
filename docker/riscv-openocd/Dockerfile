ARG OPENOCD_TAG=riscv
ARG DOCKER_USER_UID=1000
ARG BASE_IMAGE=ubuntu:focal

FROM fiveembeddev/build_env:latest AS riscv_openocd_build_config

ARG OPENOCD_TAG
ENV INSTALL_PATH=/opt/riscv-openocd/

# Clone git repos
RUN sudo apt-get update && sudo apt-get install -y ca-certificates pkg-config

RUN sudo mkdir -p /work/git  && sudo chown -R docker_user /work/
WORKDIR  /work/git
RUN git clone \
    --depth 1 \
    --branch ${OPENOCD_TAG} \
    https://github.com/riscv/riscv-openocd.git

WORKDIR  /work/git/riscv-openocd
RUN ls
RUN git submodule update \
    --init \ 
    --recommend-shallow \
    jimtcl 

RUN git submodule update \
    --init \ 
    --recommend-shallow \
    tools/git2cl \
    src/jtag/drivers/libjaylink

# Configure
RUN ./bootstrap
RUN ./configure \
    --enable-dummy \
    --enable-remote-bitbang \
    --prefix=${INSTALL_PATH} 

# Build and install
RUN make 
RUN sudo make install

# Lightwieght container with only tools, no source
ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS riscv_openocd_base

ARG DOCKER_USER_UID
ARG TZ

ENV INSTALL_PATH=/opt/riscv-openocd/

# Basic OS update
RUN apt-get update -qq 
RUN apt-get install -y sudo

# Setup user
RUN useradd \
    -u ${DOCKER_USER_UID} \
    -m \
    -r \
    -G sudo -s /sbin/nologin \
    -c "Docker image user" \
    docker_user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker_user

COPY --from=riscv_openocd_build_config ${INSTALL_PATH} ${INSTALL_PATH}

ENV PATH=${INSTALL_PATH}/bin:/bin:/usr/bin:/usr/local/bin

COPY riscv_spike.cfg /opt/riscv-openocd/

RUN sudo mkdir /project && sudo chown docker_user /project
WORKDIR /project

