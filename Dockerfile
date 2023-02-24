FROM alpine as prepare
WORKDIR /root
ADD http://file.mounriver.com/tools/MRS_Toolchain_Linux_x64_V1.60.tar.xz .
RUN apk add xz
RUN tar xvf MRS_Toolchain_Linux_x64_V1.60.tar.xz
# 用下划线替换掉路径里的空格
RUN mv "MRS_Toolchain_Linux_x64_V1.60/RISC-V Embedded GCC" MRS_Toolchain_Linux_x64_V1.60/RISC-V_Embedded_GCC



FROM ubuntu:22.04
WORKDIR /project
COPY --from=prepare /root/MRS_Toolchain_Linux_x64_V1.60  /opt/MRS_Toolchain/
ENV TOOLPATH "/opt/MRS_Toolchain/RISC-V_Embedded_GCC/bin/riscv-none-embed-"
RUN apt-get update && apt-get install -y \
  make \
  cmake \
  ninja-build \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*
CMD cmake -B build -G Ninja -DTOOLPATH="$TOOLPATH" && cmake --build build
