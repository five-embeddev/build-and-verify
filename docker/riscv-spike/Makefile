DOCKER_USER_UID:=$(shell id -u)

all : riscv_spike

riscv_spike : riscv_tools_build_env
	docker-compose build \
		--build-arg DOCKER_USER_UID=${DOCKER_USER_UID} \
		riscv_spike

riscv_tools_build_env :
	${MAKE} -C ../riscv-tool-build

riscv_openocd : 
	${MAKE} -C ../riscv-openocd

