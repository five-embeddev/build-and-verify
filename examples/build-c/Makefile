DOCKER_CMD=	docker run \
         --rm \
         -v .:/project \


all : host_out riscv-none-embed_out riscv32-unknown-elf_out

host : host_out

gnu_toolchain : riscv32-unknown-elf_out

xpack : riscv-none-embed_out

host_out : test.c
	${DOCKER_CMD} \
		fiveembeddev/build_env \
		gcc test.c -o host_out \

riscv-none-embed_out : test.c
	${DOCKER_CMD} \
		fiveembeddev/riscv_xpack_gcc_dev_env:latest  \
		riscv-none-elf-gcc \
			test.c \
			-nostartfiles \
			-o riscv-none-embed_out


riscv32-unknown-elf_out : test.c
	${DOCKER_CMD} \
		fiveembeddev/riscv_gnu_toolchain_dev_env2:latest \
		riscv32-unknown-elf-gcc \
		test.c \
		-o riscv32-unknown-elf_out

clean :
	rm -f riscv32-unknown-elf_out riscv-none-embed_out
