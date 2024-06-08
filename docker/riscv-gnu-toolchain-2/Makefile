include ../common.mak

MOUNT_BUILD_PATH=/project/build_dir
MOUNT_INSTALL_PATH=/opt/riscv-gnu-toolchain
TOOLCHAIN_TAG=master
GCC_TAG=riscv-gcc-10.2.0
RISCV_MARCH=rv32imac
RISCV_ABI=ilp32
COMPOSE_RUN_BUILD_DIR=${DOCKER_COMPOSE} run -w ${MOUNT_BUILD_PATH} build_env
COMPOSE_RUN_SRC_DIR=${DOCKER_COMPOSE} run -w ${MOUNT_BUILD_PATH}/riscv-gnu-toolchain build_env

all : dev_env

tools :  docker_build/install_dir/bin/riscv32-unknown-elf-gcc 

docker_build/install_dir/bin/riscv32-unknown-elf-gcc :
	if [ ! -d docker_build/install_dir ] ; then mkdir docker_build/install_dir; fi
	if [ ! -d build_dir ] ; then mkdir build_dir; fi
	${DOCKER_COMPOSE} build \
		--build-arg DOCKER_USER_UID=${DOCKER_USER_UID} \
		build_env
	${COMPOSE_RUN_BUILD_DIR} git clone \
		--depth 1 \
		--branch ${TOOLCHAIN_TAG} \
		https://github.com/riscv-collab/riscv-gnu-toolchain.git
	${COMPOSE_RUN_SRC_DIR} git submodule set-branch --branch ${GCC_TAG} riscv-gcc
	${COMPOSE_RUN_SRC_DIR} git submodule update  \
	    	--init \
		--recursive \
		--recommend-shallow \
		riscv-binutils riscv-dejagnu riscv-gdb riscv-glibc riscv-newlib riscv-gcc
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
