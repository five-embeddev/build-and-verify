Docker and docker-compose files for building and simulating RISC-V target code.

See <https://five-embeddev.com/> for more info.

## Dockerfiles

Each directory in `docker/` folder includes at least `Dockerfile`,
`compose.yaml` and `Makefile`. The docker `Dockerfile` will build an
image, either from source or using the OS package and tools
manager. The Docker compose `compose.yaml` is used to define the image
tags and run some commands or open a shell to check the build. The
`Makefile` is generally for convinience, the build steps are in the
`Dockerfile` and `compose.yaml` file. NOTE - `riscv-gnu-toolchain-2`
relies on the `Makefile` to build the image, as the build files are stored
outside of docker.

The docker images are designed to run tools using a user account with
user ID, `DOCKER_USER_UID`. The `Makefile` will set that to the uid of
the user building the docker images.

The docker images set the workdir to `/project`. The input and output
files can be mounted to this volume.

## Examples

The directories in `example/` will compile or simulate some target code.

The `compose.yaml` files generally include the commands, the
`Makefiles` are provided for convinience. These all assume the
required images in `docker/` have been built.



