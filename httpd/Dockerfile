FROM httpd:2.4

RUN apt-get update && apt-get install maven git openjdk-8-jdk  --no-install-recommends  -y && rm -rf /var/lib/apt/lists/*

#RUN echo "Asia/Shanghai" > /etc/timezone \
#&& dpkg-reconfigure -f noninteractive tzdata

RUN  rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["catalina.sh", "run"]
