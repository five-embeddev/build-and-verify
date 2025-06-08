# -*- Makefile -*-
#
IMAGE_NAME=riscv_gnu_toolchain2_dev_env2

include ../common.mak

RELEASE_TAG:=${RELEASE_TAG}_gcc_${GCC_TAG}

MOUNT_BUILD_PATH=/project/build_dir
MOUNT_INSTALL_PATH=/opt/riscv-gnu-toolchain
COMPOSE_RUN_BUILD_DIR=${DOCKER_COMPOSE} run -w ${MOUNT_BUILD_PATH} build_env
COMPOSE_RUN_SRC_DIR=${DOCKER_COMPOSE} run -w ${MOUNT_BUILD_PATH}/riscv-gnu-toolchain build_env
#BASE_REPO=https://github.com/riscv-collab/riscv-gnu-toolchain.git
BASE_REPO=git@github.com:riscv-collab/riscv-gnu-toolchain.git

# Https clone in docker is unreliable
#GIT_RUN_BUILD_DIR=${COMPOSE_RUN_BUILD_DIR}
#GIT_RUN_SRC_DIR=${COMPOSE_RUN_SRC_DIR}
# Do git operations in host
GIT_RUN_BUILD_DIR=cd build_dir &&
GIT_RUN_SRC_DIR=cd build_dir/riscv-gnu-toolchain &&



all : dev_env

tools :  docker_build/install_dir/bin/riscv32-unknown-elf-gcc 

docker_build/install_dir/bin/riscv32-unknown-elf-gcc :
	if [ ! -d docker_build/install_dir ] ; then mkdir docker_build/install_dir; fi
	if [ ! -d build_dir ] ; then mkdir build_dir; fi
	${DOCKER_COMPOSE} build \
		--build-arg DOCKER_USER_UID=${DOCKER_USER_UID} \
		build_env
	${COMPOSE_RUN_BUILD_DIR} rm -rf riscv-gnu-toolchain
	${GIT_RUN_BUILD_DIR} git clone \
		--depth 1 \
		--branch ${GNU_TOOLCHAIN_TAG} \
		${BASE_REPO}
	${GIT_RUN_SRC_DIR} git submodule set-branch --branch ${GCC_TAG} gcc
	${GIT_RUN_SRC_DIR} git submodule update  \
	    	--init \
		--recursive \
		--recommend-shallow \
		binutils dejagnu gdb glibc newlib gcc
	${COMPOSE_RUN_SRC_DIR} ./configure \
	    --prefix=${MOUNT_INSTALL_PATH} \
	    --with-tune=size \
	    --with-arch=${RISCV_MARCH} \
	    --with-abi=${RISCV_ABI}
	${COMPOSE_RUN_SRC_DIR} make

dev_env : docker_build/install_dir/bin/riscv32-unknown-elf-gcc
	${DOCKER_COMPOSE} build \
		--build-arg DOCKER_USER_UID=${DOCKER_USER_UID} \
		dev_env

distclean:
	rm -rf docker_build/install_dir
	rm -rf build_dir

include ../targets.mak

