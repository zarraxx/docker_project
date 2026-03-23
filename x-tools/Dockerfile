# ===== Stage 1: build x-tools =====
FROM registry.cn-hangzhou.aliyuncs.com/zarra/centos:ctng AS builder
USER root

RUN mkdir -p "/opt/x-tools" && \
    chown -R ctng:ctng "/opt/x-tools" &&\
    mkdir -p /home/ctng/src && \
    chown -R ctng:ctng /home/ctng/src 

USER ctng
WORKDIR /home/ctng/workspace
COPY --chown=ctng:ctng workspace .
ENV CT_PREFIX=/opt/x-tools/host-x86_64
WORKDIR /home/ctng/workspace/native/x86_64-centos7-linux-gnu
RUN ct-ng build || cat build.log
RUN ls /opt/x-tools/host-x86_64

#WORKDIR /home/ctng/workspace/native/aarch64-debian10-linux-gnu
#RUN CT_PREFIX_DIR=/opt/x-tools/host-$(arch) ct-ng build || cat build.log

#WORKDIR /home/ctng/workspace/native/x86_64-w64-mingw32
#RUN CT_PREFIX_DIR=/opt/x-tools/host-$(arch) ct-ng build || cat build.log

# ===== Stage 2: centos7 runtime =====

FROM registry.cn-hangzhou.aliyuncs.com/zarra/centos:7-aliyun
COPY --from=builder /opt/x-tools /opt/x-tools
ENV PATH=/opt/x-tools/host-$(arch)/x86_64-centos7-linux-gnu/bin:/opt/x-tools/host-$(arch)/aarch64-debian10-linux-gnu/bin:/opt/x-tools/host-$(arch)/x86_64-w64-mingw32/bin:$PATH
