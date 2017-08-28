FROM ubuntu:16.04

RUN apt-get update && apt-get install git pptp-linux --no-install-recommends  -y && rm -rf /var/lib/apt/lists/*

RUN  rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD *.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["start.sh"]
