# ===== Stage 1: build x-tools =====
FROM registry.cn-hangzhou.aliyuncs.com/zarra/centos:ctng AS builder
ARG ARCH=x86_64
USER root

RUN mkdir -p "/opt/x-tools" && \
    chown -R ctng:ctng "/opt/x-tools" &&\
    mkdir -p /home/ctng/src && \
    chown -R ctng:ctng /home/ctng/src 

USER ctng
WORKDIR /home/ctng/workspace
COPY --chown=ctng:ctng workspace .
ENV CT_PREFIX=/opt/x-tools
WORKDIR /home/ctng/workspace/native/x86_64-centos7-linux-gnu
RUN ct-ng build 

WORKDIR /home/ctng/workspace/native/aarch64-debian10-linux-gnu
RUN ct-ng build 

WORKDIR /home/ctng/workspace/native/x86_64-w64-mingw32
RUN ct-ng build 

RUN ls /opt/x-tools/host-${ARCH}

# ===== Stage 2: centos7 runtime =====

FROM registry.cn-hangzhou.aliyuncs.com/zarra/centos:x-tools-base
COPY --from=builder /opt/x-tools /opt/x-tools
#ENV PATH=/opt/x-tools/host-${ARCH}/x86_64-centos7-linux-gnu/bin:/opt/x-tools/host-${ARCH}/aarch64-debian10-linux-gnu/bin:/opt/x-tools/host-${ARCH}/x86_64-w64-mingw32/bin:$PATH
