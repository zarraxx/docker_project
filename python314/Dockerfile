# 1. 从基础镜像创建
FROM docker.io/python:3.14-trixie
RUN apt-get update && apt install -y --no-install-recommends  iproute2 \
        iputils-tracepath \
        iputils-ping \
        curl \
        wget \
        ca-certificates \
        netcat-openbsd \
        tcpdump \
        dnsutils && rm -rf /var/lib/apt/lists/*
RUN pip install uv
