ARG GNU_TOOLCHAIN_TAG=2022.03.09
ARG GCC_TAG=riscv-gcc-10.2.0
ARG RISCV_MARCH=rv32imac
ARG RISCV_ABI=ilp32
ARG DOCKER_USER_UID=1000
ARG BASE_IMAGE=ubuntu:jammy

# ------------------------------------------------------------------------
FROM fiveembeddev/build_env:latest  AS riscv_gnu_toolchain_build_config

ARG GNU_TOOLCHAIN_TAG
ARG GCC_TAG
ARG RISCV_MARCH
ARG RISCV_ABI

RUN sudo mkdir -p /work/git  && sudo chown -R docker_user /work/
WORKDIR  /work/git/
RUN git clone \
    --depth 1\
    --branch ${GNU_TOOLCHAIN_TAG} \
    https://github.com/riscv-collab/riscv-gnu-toolchain.git
WORKDIR  /work/git/riscv-gnu-toolchain/

ENV INSTALL_PATH=/opt/riscv-toolchain/

# Update versions
RUN git submodule set-branch --branch ${GCC_TAG} riscv-gcc
RUN git submodule update  \
    	--init \
	--recursive \
	--recommend-shallow \
	riscv-binutils riscv-dejagnu riscv-gdb riscv-glibc riscv-newlib riscv-gcc

# Configure
WORKDIR  /work/git/riscv-gnu-toolchain
RUN ./configure \
    --prefix=${INSTALL_PATH} \
    --with-tune=size \
    --with-arch=${RISCV_MARCH} \
    --with-abi=${RISCV_ABI}

# Build and install
RUN sudo mkdir -p ${INSTALL_PATH} && sudo chown -R docker_user ${INSTALL_PATH}
RUN make

# ------------------------------------------------------------------------
# Lightwieght container with only tools, no source

ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS riscv_gnu_toolchain_dev_env

ARG DOCKER_USER_UID
ARG TZ

ENV INSTALL_PATH=/opt/riscv-toolchain/

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

COPY --from=riscv_gnu_toolchain_build_config ${INSTALL_PATH} ${INSTALL_PATH}

ENV PATH=${INSTALL_PATH}/bin:/bin:/usr/bin:/usr/local/bin

RUN sudo mkdir /project && sudo chown docker_user /project
WORKDIR /project
