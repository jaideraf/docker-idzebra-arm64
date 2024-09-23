# docker-idzebra-arm64

Dockerfile for [jaideraf/idzebra-arm64](https://hub.docker.com/r/jaideraf/idzebra-arm64)

Ubuntu 20.04 (focal) (arm64) with compiled [Zebra](https://www.indexdata.com/resources/software/zebra/) engine (timezone from America/Sao_Paulo). For amd64 architecture use [jaideraf/idzebra](https://hub.docker.com/r/jaideraf/idzebra) image.

Use `--platform=linux/amd64` in the docker build command to build to that arch.

Example: `docker build -t jaideraf/idzebra-arm64 --platform=linux/amd64 .`

To see the versions installed, use:

- `docker run --rm jaideraf/idzebra-arm64:20.04 idzebra-config-2.0 --version`

- `docker run --rm jaideraf/idzebra-arm64:20.04 yaz-config --version`
