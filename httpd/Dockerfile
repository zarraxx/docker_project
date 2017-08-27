FROM httpd:2.4

RUN apt-get update && apt-get install git  --no-install-recommends  -y && rm -rf /var/lib/apt/lists/*

RUN  rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 80
CMD ["httpd-foreground"]
