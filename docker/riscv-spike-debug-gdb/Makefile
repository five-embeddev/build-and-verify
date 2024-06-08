include ../common.mak

IMAGE_NAME=riscv_spike_debug_gdb
RELEASE_TAG:=${RELEASE_TAG}_spike_${SPIKE_TAG}

all : docker-build-${IMAGE_NAME}

.PHONY: docker-build-${IMAGE_NAME}
docker-build-${IMAGE_NAME} : \
	riscv_spike.cfg \
	sim_helpers.sh \
	riscv-spike \
	riscv-openocd \
	riscv-xpack-gcc 

include ../targets.mak


