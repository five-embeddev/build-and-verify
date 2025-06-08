ARG OPENOCD_TAG=riscv
ARG DOCKER_USER_UID=1000
ARG BASE_IMAGE=ubuntu:jammy
ARG RISCV_GTKWAVE_TAG=main
ARG RISCV_GTKWAVE_URL=https://github.com/five-embeddev/riscv-gtkwave.git
ARG INSTALL_PATH=/opt/riscv_gtkwave/

# ------------------------------------------------------------------------
FROM fiveembeddev/build_env:latest AS riscv_gtkwave_build

ARG INSTALL_PATH
ARG RISCV_GTKWAVE_TAG
ARG RISCV_GTKWAVE_URL

RUN sudo mkdir -p /work/git  && sudo chown -R docker_user /work/
RUN sudo mkdir -p /opt/riscv_gtkwave  && sudo chown -R docker_user /work/
WORKDIR  /work/git/

RUN git clone \
    --depth 1\
    --recursive  \
    --branch ${RISCV_GTKWAVE_TAG} \
    ${RISCV_GTKWAVE_URL}

RUN sudo apt-get update && sudo apt-get install -y \
    python3-pip \
    device-tree-compiler \
    libboost-all-dev \
    libboost-regex-dev


WORKDIR  /work/git/riscv-gtkwave/
RUN pip3 install -r requirements.txt
RUN cd extern/riscv-isa-sim/ && ./configure
RUN	make -C extern/riscv-isa-sim/ -j8
RUN make csrs
RUN make -C src
RUN sudo mkdir -p ${INSTALL_PATH}
RUN sudo make install PREFIX_DIR=${INSTALL_PATH}

# ------------------------------------------------------------------------
ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS riscv_gtkwave_base

ARG INSTALL_PATH
ARG DOCKER_USER_UID

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

COPY --from=riscv_gtkwave_build ${INSTALL_PATH} ${INSTALL_PATH}

RUN sudo apt-get update && sudo apt-get install -y \
    libboost-regex1.71.0 \
    gtkwave 

RUN sudo mkdir /project && sudo chown docker_user /project
WORKDIR /project
