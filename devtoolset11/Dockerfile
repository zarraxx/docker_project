# 使用 CentOS 7 作为基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/zarra/centos:7


# --- 系统配置和依赖安装 ---
# 将所有安装步骤合并到一个 RUN 层，以减小镜像体积+


# ------------------[ EOL HOTFIX START ]------------------
# 1. 切换 CentOS 官方仓库指向 vault.centos.org
#    这是因为 CentOS 7 已 EOL，mirrorlist 不再工作
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=https://mirrors.aliyun.com/centos-vault|g' /etc/yum.repos.d/CentOS-*

RUN yum install -y epel-release && \
    sed -i 's/metalink=/#metalink=/g' /etc/yum.repos.d/epel.repo && \
    sed -i 's|#baseurl=http://download.fedoraproject.org/pub/epel|baseurl=https://mirrors.aliyun.com/epel-archive|g' /etc/yum.repos.d/epel.repo


# 4. 修复 SCL 仓库指向阿里云 Vault
#    SCL 的仓库文件安装后，默认指向的是已失效的官方 mirror
#    我们需要：
#    a. 注释掉 mirrorlist
#    b. 启用 baseurl
#    c. 将域名替换为阿里云 Vault
#    d. 将路径中的 /centos/7/ 替换为 /centos-vault/7.9.2009/ (关键路径修正)
RUN yum install -y centos-release-scl && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-SCLo-scl*.repo && \
    sed -i 's|# baseurl=http://mirror.centos.org|baseurl=https://mirrors.aliyun.com|g' /etc/yum.repos.d/CentOS-SCLo-scl*.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=https://mirrors.aliyun.com|g' /etc/yum.repos.d/CentOS-SCLo-scl*.repo


RUN yum install -y \
    devtoolset-11-gcc \
    devtoolset-11-gcc-c++ \
    devtoolset-11-binutils \
    make \
    git \
    wget \
    patch \
    unzip bzip2 lzma perl perl-Data-Dumper perl-Pod-Markdown perl-IPC-Cmd perl-Thread-Queue cmake flex bison nasm help2man which file pam-devel systemd-devel \
    && yum clean all
