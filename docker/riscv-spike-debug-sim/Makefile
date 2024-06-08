include ../common.mak

IMAGE_NAME=riscv_spike_debug_sim
RELEASE_TAG:=${RELEASE_TAG}_spike_${SPIKE_TAG}

all : docker-build-${IMAGE_NAME}

docker-build-${IMAGE_NAME} : riscv-spike riscv-openocd riscv_spike.cfg

include ../targets.mak


