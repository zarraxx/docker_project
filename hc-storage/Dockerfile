FROM openjdk:8-jdk

#RUN apt-get update && apt-get install maven git openjdk-8-jdk  --no-install-recommends  -y && rm -rf /var/lib/apt/lists/*

RUN  rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/*

RUN mkdir -p /var/ext/upload

ADD storage-frontend.war /var/ext/upload/storage-frontend.war


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["java", "-jar" ,"/var/ext/upload/storage-frontend.war"]
