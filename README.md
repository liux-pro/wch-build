# wch-build
A docker image contain WCH RISC-V MCU build toolchain.
There is a [example CH582 project](https://github.com/liux-pro/CH582-CMake) show how to config project struct that fit this docker image.

# docker image
The pre-build docker image has been push to two public registry.
They are built by ACR(Alibaba Cloud Container Registry) and Github Action from the same `Dockerfile`.
```bash
registry.cn-shenzhen.aliyuncs.com/liux-pro/wch-build
ghcr.io/liux-pro/wch-build
```

# build hex file
```bash
git clone https://github.com/liux-pro/CH582-CMake.git
cd CH582-CMake
docker run -t --rm -v $PWD:/project registry.cn-shenzhen.aliyuncs.com/liux-pro/wch-build
```
# build hex file with Github Action
```yaml
name: Build Artifact

on:
  push:
    branches: [ "master" ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          submodules: recursive
          
      - name: Build With Docker
        run: docker run -t --rm -v $PWD:/project ghcr.io/liux-pro/wch-build:latest
        
      - name: Upload Artifact
        uses: actions/upload-artifact@v3
        with:
          name: hex file
          path: ./build/*.hex
```