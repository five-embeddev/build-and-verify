# Docker environment for running Rust for cross compilation for RISC-V.

|       |                                         |
|-------|-----------------------------------------|
|*Image*| `fiveembeddev/riscv_rustup_dev_env:latest`|
|*User*| `docker_user`|
|*Home Dir*| `/home/docker_user`|
|*Workdir*| `/project`|
|*Tool Path*| `/home/docker_user/.cargo`|


The compile is installed using rustup <https://rust-lang.github.io/rustup/>

RISC-V was a tier-2 platform when this was `Dockerfile` developed. (<https://doc.rust-lang.org/nightly/rustc/platform-support.html#tier-2>)

More info about rust for embedded targets <https://docs.rust-embedded.org/>.

```bash
docker run \
    --tty \
    --interactive \
    --rm \
    -v .:/project \
     fiveembeddev/riscv_rustup_dev_env:latest \
    rustc --version
```
