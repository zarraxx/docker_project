FROM gzm55/vpn-client


ADD *.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["start.sh"]
