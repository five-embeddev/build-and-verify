FROM ubuntu:focal AS riscv_tools_build_env

ARG DOCKER_USER_UID=1000
ARG TZ=UTC

# Basic OS update
RUN apt-get update -qq 
RUN apt-get install -y sudo

# Setup user
RUN useradd \
    -u ${DOCKER_USER_UID} \
    -r \
    -G sudo -s /sbin/nologin \
    -c "Docker image user" \
    docker_user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker_user

# Basic OS update
RUN DEBIAN_FRONTEND="noninteractive" sudo apt-get update && sudo apt-get -y install tzdata
RUN sudo apt-get update && sudo apt-get install -y git
RUN sudo apt-get update && sudo apt-get install -y \
    bison \
    build-essential \
    flex
    
RUN sudo apt-get update && sudo apt-get install -y \
    autoconf \
    automake \
    autotools-dev
    
RUN sudo apt-get update && sudo apt-get install -y \
    bc \
    curl \
    gawk \
    gperf \
    libtool \
    patchutils \
    python3 \
    texinfo
    
RUN sudo apt-get update && sudo apt-get install -y \
    libexpat-dev \
    libgmp-dev \
    libmpc-dev \
    libmpfr-dev \
    zlib1g-dev 

RUN sudo mkdir /project && sudo chown docker_user /project
RUN sudo chown docker_user /opt
WORKDIR /project

