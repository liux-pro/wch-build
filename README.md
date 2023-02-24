# wch-build
A docker image contain WCH RISC-V MCU build toolchain

# usage
docker run -t --rm -v $PWD:/project registry.cn-shenzhen.aliyuncs.com/liux-pro/wch-build

# example 
```bash
git clone https://github.com/liux-pro/CH582-CMake.git
cd CH582-CMake
docker run -t --rm -v $PWD:/project registry.cn-shenzhen.aliyuncs.com/liux-pro/wch-build
```