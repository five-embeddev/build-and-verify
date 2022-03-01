DOCKER_USER_UID:=$(shell id -u)

riscv_rustup_rustc :
	docker-compose \
		build \
		--build-arg DOCKER_USER_UID=${DOCKER_USER_UID} \
		build_env

