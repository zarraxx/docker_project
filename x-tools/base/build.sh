set -e
ROOT=$(cd `dirname $0` && pwd)
yum install -y openssl-devel 
yum install -y  rh-python38

source /opt/rh/rh-python38/enable
source /opt/rh/devtoolset-10/enable

source $ROOT/var.sh


build_libbacktrace(){
    download_file "libbacktrace.zip"
    cd $BUILD_DIR
    rm -rf libbacktrace*
    unzip $ARCHIVE_DIR/libbacktrace.zip
    cd libbacktrace-master

    ./configure --prefix=${DEST_DIR} 
    make -j$(nproc)
    make install
    #mkdir -p ${DEPENDENCY_LIBS_PATH}
}

build_libtool(){
    download_file "libtool-$LIBTOOL_VERSION.tar.xz"
    cd $BUILD_DIR
    rm -rf libtool*
    tar xvf $ARCHIVE_DIR/libtool-$LIBTOOL_VERSION.tar.xz
    cd libtool-$LIBTOOL_VERSION

    ./configure --prefix=${DEST_DIR}
    make -j$(nproc)
    make install
}


build_autoconf(){
    download_file "autoconf-$AUTOCONF_VERSION.tar.xz"
    cd $BUILD_DIR
    rm -rf autoconf*
    tar xvf $ARCHIVE_DIR/autoconf-$AUTOCONF_VERSION.tar.xz
    cd autoconf-$AUTOCONF_VERSION

    ./configure --prefix=${DEST_DIR}
    make -j$(nproc)
    make install
}


build_automake(){
    download_file "automake-$AUTOMAKE_VERSION.tar.xz"
    cd $BUILD_DIR
    rm -rf automake*
    tar xvf $ARCHIVE_DIR/automake-$AUTOMAKE_VERSION.tar.xz
    cd automake-$AUTOMAKE_VERSION
    ORIG_PATH=$PATH
    export PATH=${DEST_DIR}/bin:$PATH
    ./configure --prefix=${DEST_DIR}
    make -j$(nproc) 
    make install 
    export PATH=$ORIG_PATH
}

build_nasm(){
    download_file "nasm-$NASM_VERSION.tar.xz"
    cd $BUILD_DIR
    rm -rf nasm*
    tar xvf $ARCHIVE_DIR/nasm-$NASM_VERSION.tar.xz
    cd nasm-$NASM_VERSION
    ./autogen.sh
    ./configure --prefix=$DEST_DIR
    make -j$(nproc)
    make install
}

build_patchelf(){
    download_file "patchelf-$PATCHELF_VERSION.tar.bz2"
    cd $BUILD_DIR
    rm -rf patchelf*
    tar xvf $ARCHIVE_DIR/patchelf-$PATCHELF_VERSION.tar.bz2
    cd patchelf-$PATCHELF_VERSION

    ./configure --prefix=${DEST_DIR}
    make -j$(nproc)
    make install
}

build_make(){
    download_file "make-$MAKE_VERSION.tar.gz"
    cd $BUILD_DIR
    rm -rf make*
    tar xvf $ARCHIVE_DIR/make-$MAKE_VERSION.tar.gz
    cd make-$MAKE_VERSION

    ./configure --prefix=${DEST_DIR}
    make -j$(nproc)
    make install
}

build_ninja(){
    download_file "ninja-$NINJA_VERSION.tar.gz"
    cd $BUILD_DIR
    rm -rf ninja*
    tar xvf $ARCHIVE_DIR/ninja-$NINJA_VERSION.tar.gz
    cd ninja-$NINJA_VERSION

    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${DEST_DIR} .
    make -j$(nproc)
    make install
}

build_cmake(){
    download_file "cmake-$CMAKE_VERSION.tar.gz"
    cd $BUILD_DIR
    rm -rf cmake*
    tar xvf $ARCHIVE_DIR/cmake-$CMAKE_VERSION.tar.gz
    cd cmake-$CMAKE_VERSION

    ./bootstrap --prefix=${DEST_DIR}
    make -j$(nproc)
    make install
}

build_llvm(){
    download_file "llvm-project-$LLVM_VERSION.src.tar.xz"
    cd $BUILD_DIR
    rm -rf llvm*
    tar xvf $ARCHIVE_DIR/llvm-project-$LLVM_VERSION.src.tar.xz
    PYTHON_EXE=$(which python3)
    cd llvm-project-$LLVM_VERSION.src
    mkdir _build && cd _build
    cmake -G "Unix Makefiles" \
     -DPython3_EXECUTABLE=$PYTHON_EXE \
      -DLLVM_ENABLE_PROJECTS="clang" \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
      -DBUILD_SHARED_LIBS=OFF \
      -DLLVM_ENABLE_RTTI=ON \
      -DCMAKE_INSTALL_PREFIX=${DEST_DIR} ../llvm
    make -j4
    make install
}
build_google_test(){
    download_file "googletest-release-$GOOGLETEST_VERSION.zip"
    cd $BUILD_DIR
    rm -rf googletest*
    unzip $ARCHIVE_DIR/googletest-release-$GOOGLETEST_VERSION.zip
    cd googletest-release-$GOOGLETEST_VERSION
    mkdir _build && cd _build
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${DEST_DIR} ..
    make -j$(nproc)
    make install
}

build_meson(){
    download_file "meson-$MESON_VERSION.tar.gz"
    cd $BUILD_DIR
    rm -rf meson*
    tar xvf $ARCHIVE_DIR/meson-$MESON_VERSION.tar.gz
    cd meson-$MESON_VERSION

    ./packaging/create_zipapp.py --outfile ${DEST_DIR}/bin/meson --interpreter '/usr/bin/env python3'
    #python3 setup.py install --prefix=${DEST_DIR}
}

download_maven(){
    download_file "apache-maven-$MAVEN_VERSION-bin.tar.gz"
    cd $BUILD_DIR
    rm -rf apache-maven*
    tar xvf $ARCHIVE_DIR/apache-maven-$MAVEN_VERSION-bin.tar.gz
    cd apache-maven-$MAVEN_VERSION
    cp -r bin boot conf lib ${DEST_DIR}/
}

build_libbacktrace
build_libtool
build_autoconf

export PATH=${DEST_DIR}/bin:$PATH
build_automake
build_make
build_patchelf
build_nasm
build_cmake
build_ninja
#build_llvm
build_google_test
download_maven
build_meson