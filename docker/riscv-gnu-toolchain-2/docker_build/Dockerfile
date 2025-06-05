ARG DOCKER_USER_UID=1000

# ------------------------------------------------------------------------
# Lightwieght container with only tools, no source
ARG BASE_IMAGE=ubuntu:jammy
FROM ${BASE_IMAGE} AS riscv_gnu_toolchain_dev_env2

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

COPY install_dir ${INSTALL_PATH}

RUN sudo apt-get install -y libmpc3

ENV PATH=${INSTALL_PATH}bin:/bin:/usr/bin:/usr/local/bin

RUN sudo mkdir /project && sudo chown docker_user /project
WORKDIR /project
