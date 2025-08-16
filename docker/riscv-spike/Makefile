# -*- Makefile -*-
include ../common.mak

IMAGE_NAME=riscv_spike_dev_env
COMPOSE_TARGET=riscv_spike

# Override to choose spike fork
SPIKE_TAG=${SPIKE_LATEST_HASH}
SPIKE_DATE=${SPIKE_LATEST_DATE}
RELEASE_TAG:=${RELEASE_TAG}_spike_${SPIKE_DATE}_${SPIKE_TAG}

DOCKER_BUILD_ARGS += \
	SPIKE_TAG=${SPIKE_TAG} \
	SPIKE_URL=${SPIKE_URL}

all : docker-build-${IMAGE_NAME}

docker-build-${IMAGE_NAME} : riscv-tool-build

include ../targets.mak

