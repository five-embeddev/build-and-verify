include ../common.mak

IMAGE_NAME=riscv_openocd_base

# Override to choose spike fork
RELEASE_TAG:=${RELEASE_TAG}_openocd_${OPENOCD_TAG}

DOCKER_BUILD_ARGS += \
	OPENOCD_TAG=${OPENOCD_TAG} \

all : docker-build-${IMAGE_NAME}

docker-build-${IMAGE_NAME} : riscv-tool-build

include ../targets.mak
