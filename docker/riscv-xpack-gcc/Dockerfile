ARG XPACK_GCC_VERSION=12.2.0-3.1
#ARG XPACK_GCC_VERSION=10.1.0-1.1.1
ARG PACKAGE=riscv-none-elf-gcc
ARG NODE_VERSION=16.16.0
ARG NVM_VERSION=v0.38.0
ARG DOCKER_USER_UID=1000
ARG TZ=UTC
ARG BASE_IMAGE=ubuntu:focal

FROM ${BASE_IMAGE} AS riscv_xpack_gcc_base_env 

ARG DOCKER_USER_UID
ARG TZ

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

# Basic OS Tools
RUN DEBIAN_FRONTEND="noninteractive" sudo apt-get -y install tzdata
RUN sudo apt-get update && sudo apt-get install -y cmake
RUN sudo apt-get update && sudo apt-get install -y curl

# ------------------------------------------------------------------------
# Node install
FROM riscv_xpack_gcc_base_env  AS riscv_xpack_gcc_node_env 

ARG NODE_VERSION
ARG NVM_VERSION

# Node is used to install xpack
ENV NVM_DIR=/home/docker_user/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash

RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}

# Check it works
ENV PATH="/home/docker_user/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# ------------------------------------------------------------------------
# XPM install
FROM riscv_xpack_gcc_node_env AS riscv_xpack_gcc_xpm_env 

ARG XPACK_GCC_VERSION
ARG PACKAGE

ENV XPACKS_REPO_FOLDER=/home/docker_user/.xpack/repos
ENV XPACKS_SYSTEM_FOLDER=/home/docker_user/.xpack/system

RUN npm install --global xpm@latest
RUN xpm install --global --verbose  @xpack-dev-tools/${PACKAGE}@${XPACK_GCC_VERSION}   
# ------------------------------------------------------------------------
# Just the embedded dev tools - no node or xpm

FROM riscv_xpack_gcc_base_env  AS riscv_xpack_gcc_dev_env 

ARG XPACK_GCC_VERSION
ARG PACKAGE

COPY --from=riscv_xpack_gcc_xpm_env /home/docker_user/.xpack/ /home/docker_user/.xpack/

ENV PATH=/home/docker_user/.xpack/repos/@xpack-dev-tools/${PACKAGE}/${XPACK_GCC_VERSION}/.content/bin:/bin/:/usr/bin

RUN sudo ln -s /home/docker_user/.xpack/repos/@xpack-dev-tools/${PACKAGE}/${XPACK_GCC_VERSION}/.content /opt/riscv-none-embed

RUN sudo mkdir /project && sudo chown docker_user /project
WORKDIR /project
