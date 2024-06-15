test.elf : test.rs
	docker run \
         --rm \
         -v .:/project \
          fiveembeddev/riscv_rustup_dev_env:latest \
         rustc \
			--target riscv32imac-unknown-none-elf \
			/project/test.rs \
			-o test.elf

