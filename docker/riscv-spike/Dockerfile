ARG DOCKER_USER_UID=1000
ARG SPIKE_TAG=master
ARG TZ=UTC

# ------------------------------------------------------------------------
FROM five_embeddev/build_env:latest  AS riscv_spike_build_config

ARG SPIKE_TAG
ENV INSTALL_PATH=/opt/riscv-isa-sim/

RUN sudo apt-get update -qq && sudo apt-get install -y device-tree-compiler


RUN sudo mkdir -p /work/git  && sudo chown -R docker_user /work/
WORKDIR  /work/git/

RUN git clone \
    --depth 1\
    --recursive  \
    --branch ${SPIKE_TAG} \
    https://github.com/riscv-software-src/riscv-isa-sim.git

WORKDIR  /work/git/riscv-isa-sim
RUN git submodule update  \
    --init \
    --recursive \
    --recommend-shallow 
	   
# Configure
RUN mkdir build/
WORKDIR  /work/git/riscv-isa-sim/build
RUN ../configure \
    --enable-histogram \
    --prefix=${INSTALL_PATH} 

# Build and install
RUN make
RUN sudo make install

# ------------------------------------------------------------------------
# Lightwieght container with only tools, no source
FROM ubuntu:focal AS riscv_spike_dev_env

ARG DOCKER_USER_UID

RUN apt-get update -qq && apt-get install -y device-tree-compiler 

ENV INSTALL_PATH=/opt/riscv-isa-sim

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

COPY --from=riscv_spike_build_config ${INSTALL_PATH} ${INSTALL_PATH}

USER docker_user
ENV PATH=${INSTALL_PATH}/bin:/bin:/usr/bin:/usr/local/bin

RUN sudo mkdir /project && sudo chown docker_user /project
WORKDIR /project

