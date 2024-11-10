
.PHONY: 
build:  docker-build-${IMAGE_NAME}


.PHONY: compose-build-${IMAGE_NAME}
compose-build-${IMAGE_NAME} : 
	${DOCKER_COMPOSE} build \
		${DOCKER_BUILD_ARGS:%=--build-arg %} \
		${IMAGE_NAME}

.PHONY: docker-build-${IMAGE_NAME}
docker-build-${IMAGE_NAME} : 
	${DOCKER} build ${NO_CACHE} \
		${DOCKER_BUILD_ARGS:%=--build-arg %} \
		--tag ${BUILD_TAG} \
		.

# 		--progress=plain \

.PHONY: shell
shell : 
	${DOCKER} run \
		--tty \
		--interactive \
		--rm \
		--user ${DOCKER_USER_UID}:${DOCKER_USER_GID} \
		-v .:/project \
		${DOCKER_RUN_ARGS} \
        --entrypoint ${DOCKER_RUN_SHELL} \
		 ${BUILD_TAG} 
        

.PHONY: push
push : 
	${DOCKER} push ${BUILD_TAG}
	docker tag ${BUILD_TAG} ${RELEASE_TAG}
	${DOCKER} push ${RELEASE_TAG}

COMPILE_DIRS=\
	riscv-gnu-toolchain \
	riscv-gnu-toolchain-2 \
	riscv-openocd \
	riscv-rust \
	riscv-spike \
	riscv-spike-debug-sim \
	riscv-tool-build \
	riscv-xpack-gcc

.PHONY: ${COMPILE_DIRS}
${COMPILE_DIRS} :
	${MAKE} -C ../$@

.PHONY: riscv-spike-vcd
riscv-spike-vcd :
	${MAKE} -C ../riscv-spike -f Makefile.vcd_spike



riscv_spike.cfg : ../riscv-openocd/riscv_spike.cfg
	cp $<  $@ 

sim_helpers.sh : ../riscv-spike-debug-sim/sim_helpers.sh
	cp $<  $@ 
