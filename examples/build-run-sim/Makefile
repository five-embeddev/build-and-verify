RISCV_ISA=rv32imac
RISCV_PRIV=m
# See test_code/linker.lds
BOARD_MEM=0x8000000:0x2000,0x80000000:0x4000,0x20010000:0x6a120
BITBANG_PORT=9824
ELF_FILE=/project/build/main.elf

DOCKER_CMD=	docker run \
         --rm \
         -v .:/project \
         -v ${CURDIR}/../test-code-c:/project/test_code

build:
	${DOCKER_CMD} \
		fiveembeddev/riscv_xpack_gcc_dev_env:latest \
		cmake \
			-S test_code \
			-B build \
			-G "Unix Makefiles" \
			-DCMAKE_TOOLCHAIN_FILE=../test_code/riscv.cmake
	${DOCKER_CMD} \
		fiveembeddev/riscv_xpack_gcc_dev_env:latest \
			make \
				VERBOSE=1 \
				-C build


sim:
	${DOCKER_CMD} \
		fiveembeddev/riscv_spike_dev_env:latest \
		/opt/riscv-isa-sim/bin/spike \
			-l \
			-d \
			--isa=${RISCV_ISA} \
			--priv=${RISCV_PRIV} \
			-m${BOARD_MEM}  \
			--pc=0x20010000 \
			${ELF_FILE}

gdb:
	${DOCKER_CMD} \
			-it \
		fiveembeddev/riscv_spike_debug_gdb:latest \
			${ELF_FILE}

sim_help:
	docker-compose run sim_test_code \
		/opt/riscv-isa-sim/bin/spike \
			--help

.PHONY : build sim
