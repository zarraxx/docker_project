#!/bin/bash

set -e
ROOT=$(cd `dirname $0` && pwd)
yum install -y \
    devtoolset-10-gcc \
    devtoolset-10-gcc-c++ \
    devtoolset-10-binutils 

source /opt/rh/rh-python38/enable
source /opt/rh/devtoolset-10/enable

source $ROOT/var.sh

mkdir -p ${BUILD_DIR}
mkdir -p ${DEST_DIR}
mkdir -p ${ARCHIVE_DIR}


export PATH=${DEST_DIR}/bin:$PATH



build_llvm(){
    download_file "llvm-project-$LLVM_VERSION.src.tar.xz"
    cd $BUILD_DIR
    rm -rf llvm*
    tar xf $ARCHIVE_DIR/llvm-project-$LLVM_VERSION.src.tar.xz
    PYTHON_EXE=$(which python3)
    cd llvm-project-$LLVM_VERSION.src
    rm -rf _build && mkdir _build && cd _build
    cmake -G Ninja \
     -DCMAKE_BUILD_TYPE=Release \
      -DPython3_EXECUTABLE=$PYTHON_EXE \
      -DCMAKE_INSTALL_PREFIX=${LLVM_DEST_DIR} \
      \
      -DLLVM_ENABLE_PROJECTS="clang;lld" \
      -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
      -DCLANG_DEFAULT_LINKER="lld" \
      \
      -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
      \
      -DLLVM_ENABLE_RTTI=ON \
      -DLLVM_INSTALL_UTILS=ON \
      -DLLVM_BUILD_LLVM_DYLIB=ON \
      -DLLVM_LINK_LLVM_DYLIB=ON \
      -DCLANG_LINK_CLANG_DYLIB=ON \
      \
      -DLLVM_INCLUDE_TESTS=OFF \
      -DLLVM_INCLUDE_EXAMPLES=OFF \
      -DLLVM_ENABLE_TERMINFO=OFF \
      -DLLVM_ENABLE_ZLIB=ON \
      -DLLVM_ENABLE_LIBXML2=OFF \
      -DCMAKE_EXE_LINKER_FLAGS="-static-libstdc++ -static-libgcc" \
      -DCMAKE_INSTALL_RPATH="\$ORIGIN;\$ORIGIN/../lib" \
      -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
       ../llvm

    ninja -j$(nproc) 
    ninja install


}



export LLVM_DEST_DIR=/opt/x-tools/compilers/llvm
build_llvm
