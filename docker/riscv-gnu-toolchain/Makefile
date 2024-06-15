include ../common.mak

IMAGE_NAME=riscv_gnu_toolchain_dev_env

# Override to choose spike fork
RELEASE_TAG:=${RELEASE_TAG}_gcc_${GCC_TAG}

DOCKER_BUILD_ARGS += \
    GNU_TOOLCHAIN_TAG=${GNU_TOOLCHAIN_TAG} \
	GCC_TAG=${GCC_TAG} \
	RISCV_MARCH=${RISCV_MARCH} \
	RISCV_ABI=${RISCV_ABI}

all : docker-build-${IMAGE_NAME}

docker-build-${IMAGE_NAME} : riscv-tool-build

include ../targets.mak
