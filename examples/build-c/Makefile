all : host_out riscv-none-embed_out riscv32-unknown-elf_out

host : host_out

gnu_toolchain : riscv32-unknown-elf_out

xpack : riscv-none-embed_out

host_out : test.c
	docker-compose run build_host

riscv-none-embed_out : test.c
	docker-compose run build_xpack

riscv32-unknown-elf_out : test.c
	docker-compose run build_gnu_toolchain
