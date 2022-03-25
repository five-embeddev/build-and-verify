RISCV_ISA=rv32imac
RISCV_PRIV=m
# See test_code/linker.lds
BOARD_MEM=0x8000000:0x2000,0x80000000:0x4000,0x20010000:0x6a120
ELF_FILE=/project/build/main.elf

setup : build_docker build_img
	@echo "Docker images and test image setup, run these commands."
	@echo "   make sim - run spike simulator with port open"
	@echo "   make gdb - run gdb connected to spike"
	@echo "   make gdb_sim - run gdb with spike"

build_docker:
	docker-compose build

build_img:
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
	docker-compose run spike_openocd \
			--isa=${RISCV_ISA} \
			--priv=${RISCV_PRIV} \
			-m${BOARD_MEM}  \
			--pc=0x20010000 \
			${ELF_FILE}


gdb_sim:
	docker-compose run spike_openocd_gdb \
			--isa=${RISCV_ISA} \
			--priv=${RISCV_PRIV} \
			-m${BOARD_MEM}  \
			--pc=0x20010000 \
			${ELF_FILE}


gdb : 
		docker-compose run spike_gdb \
			${ELF_FILE}

clean :
	rm -rf build

