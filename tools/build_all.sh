#!/bin/sh
# Build all required tools

# Install required libraries

#   ghdl
sudo apt-get install gnat
#   arm
sudo apt-get install gcc-arm-none-eabi
#   riscv
sudo apt-get install autoconf automake autotools-dev curl device-tree-compiler \
    libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk build-essential \
    bison flex texinfo gperf libtool patchutils bc zlib1g-dev pkg-config



# Build official RISC-V toolchain
cd tools/install
./build_ghdl.sh
#./build_riscv_tools.sh
./build_riscv_gcc.sh --arch=rv64i --prefix=$(pwd)/../rv64i
./build_riscv_gcc.sh --arch=rv64imfd --prefix=$(pwd)/../rv64imfd
cd ../..

# Build internal tools
make -C tools/shexdump

# Build libraries
make -C baremetal/arch
