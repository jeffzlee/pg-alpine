FROM alpine:edge

#RUN apk update && \
#    apk add curl  postgresql-client postgresql postgresql-contrib 
    # && \
   # mkdir /docker-entrypoint-initdb.d && \
  #  curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" && \
  #  chmod +x /usr/local/bin/gosu && \
 #   apk del curl && \
 #   rm -rf /var/cache/apk/*
 
#ENV LANG en_US.utf8
#ENV PGDATA /var/lib/postgresql/data
# VOLUME /var/lib/postgresql/data

#COPY docker-entrypoint.sh /

# ENTRYPOINT ["/docker-entrypoint.sh"]
# ENTRYPOINT ["/bin/sh"]
#EXPOSE 5432
# CMD ["postgres"]
CMD ["/bin/sh"]

