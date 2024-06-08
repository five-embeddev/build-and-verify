Docker environment for building RISC-V tools.

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/build_env:latest`|
|*User*| `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/opt/riscv-gtkwave/`|

Build tools (g++, autoconf, etc) and libraries for building development tools.

Non-root user environment and workdir.

```bash
docker run \
    --tty \
    --interactive \
    --rm \
     -v .:/project \
     fiveembeddev/build_env:latest
```

```bash
docker_user@4b308be4da67:/project$ gcc --version
gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

docker_user@4b308be4da67:/project$ autoconf --version
autoconf (GNU Autoconf) 2.69
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+/Autoconf: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>, <http://gnu.org/licenses/exceptions.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by David J. MacKenzie and Akim Demaille.
docker_user@4b308be4da67:/project$
```
