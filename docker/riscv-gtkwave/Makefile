include ../common.mak

IMAGE_NAME=riscv_gtkwave_base

RISCV_GTKWAVE_TAG=docker_build_9da3e8c8a6
RISCV_GTKWAVE_URL=https://github.com/five-embeddev/riscv-gtkwave.git

# Override to choose spike fork
RELEASE_TAG:=${RELEASE_TAG}_decoders_${RISCV_GTKWAVE_TAG}

DOCKER_BUILD_ARGS += \
	RISCV_GTKWAVE_TAG=${RISCV_GTKWAVE_TAG} \
	RISCV_GTKWAVE_URL=${RISCV_GTKWAVE_URL}

DOCKER_RUN_ARGS += \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=${DISPLAY}

DOCKER_RUN_SHELL=gtkwave

all : docker-build-${IMAGE_NAME}

docker-build-${IMAGE_NAME} : riscv-tool-build

include ../targets.mak
