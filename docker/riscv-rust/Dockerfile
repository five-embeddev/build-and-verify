ARG DOCKER_USER_UID=1000
ARG TZ=UTC

# ------------------------------------------------------------------------
# Just the RUST installer

FROM ubuntu:focal AS riscv_rustup_env 

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

WORKDIR /home/docker_user

# Basic OS Tools
RUN DEBIAN_FRONTEND="noninteractive" sudo apt-get -y install tzdata
RUN sudo apt-get install -y curl

RUN curl \
    --proto '=https' \
    	    --tlsv1.2 \
	    -sSf \
	    https://sh.rustup.rs \
	    -o  setup.rustup.sh
	    
RUN sh ./setup.rustup.sh \
    -y \
     --no-modify-path \
    --profile minimal \    
    --default-toolchain stable

ENV PATH=/home/docker_user/.cargo/bin:/bin/:/usr/bin

RUN sudo mkdir /project && sudo chown docker_user /project
WORKDIR /project

# ------------------------------------------------------------------------
# Add the RISC-V target

FROM riscv_rustup_env  AS riscv_rust_dev_env


RUN rustup target add riscv32imac-unknown-none-elf	
RUN rustup target add riscv32i-unknown-none-elf
RUN rustup target add riscv32imac-unknown-none-elf
RUN rustup target add riscv32imc-unknown-none-elf
RUN rustup target add riscv64gc-unknown-none-elf
RUN rustup target add riscv64imac-unknown-none-elf

RUN sudo apt-get install -y build-essential

# For cargo objdump etc
RUN cargo install cargo-binutils
RUN rustup component add llvm-tools-preview


