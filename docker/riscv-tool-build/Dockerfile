ARG BASE_IMAGE=ubuntu:jammy
FROM ${BASE_IMAGE} AS riscv_tools_build_env

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
    --create-home \
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

# HTTP Git clone is unreliable for gcc etc
# gh cli may resolve this, but need to setup token.
# RUN sudo apt-get update && sudo apt-get install -y \
#     gpg
# RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
#     | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
# RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
#     | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null;
# RUN sudo apt-get update && sudo apt-get install -y \
#     gh


RUN sudo mkdir /project && sudo chown docker_user /project
RUN sudo chown docker_user /opt
WORKDIR /project

