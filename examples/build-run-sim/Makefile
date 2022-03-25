RISCV_ISA=rv32imac
RISCV_PRIV=m
# See test_code/linker.lds
BOARD_MEM=0x8000000:0x2000,0x80000000:0x4000,0x20010000:0x6a120
BITBANG_PORT=9824
ELF_FILE=/project/build/main.elf


build:
	docker-compose run build_test_code \
		cmake \
			-S test_code \
			-B build \
			-G "Unix Makefiles" \
			-DCMAKE_TOOLCHAIN_FILE=../test_code/riscv.cmake
	docker-compose run build_test_code \
		make \
			-C build


sim:
	docker-compose run sim_test_code \
		/opt/riscv-isa-sim/bin/spike \
			-l \
			-d \
			--isa=${RISCV_ISA} \
			--priv=${RISCV_PRIV} \
			-m${BOARD_MEM}  \
			--pc=0x20010000 \
			${ELF_FILE}

sim_help:
	docker-compose run sim_test_code \
		/opt/riscv-isa-sim/bin/spike \
			--help

.PHONY : build sim
