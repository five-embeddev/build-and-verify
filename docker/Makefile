
.PHONY: build push
build push :
	${MAKE} -C riscv-tool-build/ $@
	${MAKE} -C riscv-spike/ $@
	${MAKE} -C riscv-spike/ -f Makefile.vcd_spike $@
	${MAKE} -C riscv-openocd/ $@
	${MAKE} -C riscv-xpack-gcc/ $@
	${MAKE} -C riscv-spike-debug-sim/ $@
	${MAKE} -C riscv-spike-debug-sim/  -f Makefile.vcd_spike $@
	${MAKE} -C riscv-spike-debug-gdb/ $@
	${MAKE} -C riscv-rust/ $@

.PHONY: login
login : 
	docker login \
		-u fiveembeddev 


