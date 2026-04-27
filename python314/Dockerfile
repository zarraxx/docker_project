# 1. 从基础镜像创建
FROM docker.io/python:3.14-trixie
RUN apt install -y --no-install-recommends inetutils-telnet iputils-tracepath iputils-ping curl wget gnupg ca-certificates && rm -rf /var/lib/apt/lists/*
RUN pip install uv
