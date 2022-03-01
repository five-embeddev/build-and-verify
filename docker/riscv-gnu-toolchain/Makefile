DOCKER_USER_UID:=$(shell id -u)

riscv_gnu_toolchain : riscv_tools_build_env
	docker-compose build \
		--build-arg DOCKER_USER_UID=${DOCKER_USER_UID} \
		build_env

riscv_tools_build_env :
	${MAKE} -C ../riscv-tool-build
