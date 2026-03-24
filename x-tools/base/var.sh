
export AUTOCONF_VERSION=2.73
export AUTOMAKE_VERSION=1.16.5
export LIBTOOL_VERSION=2.4.6
export PATCHELF_VERSION=0.18.0
export CMAKE_VERSION=3.25.0
export LLVM_VERSION=21.1.8
export GOOGLETEST_VERSION=1.11.0
export NASM_VERSION=2.16.03
export MAVEN_VERSION=3.6.3
export NINJA_VERSION=1.13.2
export MAKE_VERSION=4.3
export MESON_VERSION=1.10.2


ARCH=$(uname -m)


export BUILD_DIR=/workspace/build
export DEST_DIR=/opt/x-tools/utils
export ARCHIVE_DIR=/workspace/archive

mkdir -p ${BUILD_DIR}
mkdir -p ${DEST_DIR}
mkdir -p ${ARCHIVE_DIR}


# 下载文件函数
# 用法: download_file <filename>
# 示例: download_file "openssl-3.1.8.tar.gz"
download_file() {
    local filename=$1
    local archive_dir=$ARCHIVE_DIR
    local base_url="https://bsoft.oss-cn-hangzhou.aliyuncs.com/static/source"
    local file_path="${archive_dir}/${filename}"
    
    if [ -f "${file_path}" ]; then
        echo "文件已存在，跳过下载: ${filename}"
        return 0
    fi
    
    echo "正在下载: ${filename}"
    wget -P "${archive_dir}" "${base_url}/${filename}"
    
    if [ $? -eq 0 ]; then
        echo "下载完成: ${filename}"
    else
        echo "下载失败: ${filename}"
        return 1
    fi
}
