FROM alpine:edge
MAINTAINER @JeffZLee https://github.com/jeffzlee


#RUN apk update && \
#addgroup postgres postgres

RUN apk update && \
apk add wget dpkg gnupg

ENV GOSU_VERSION 1.7
RUN set -x \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/tag/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/tag/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver pgp.mit.edu --recv-keys 0x036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    ;


# 036A9C25BF357DD4 - Tianon Gravi <tianon@tianon.xyz> 
# http://pgp.mit.edu/pks/lookup?op=vindex&search=0x036A9C25BF357DD4 

ADD . /code
WORKDIR /code
COPY docker-entrypoint.sh  /
WORKDIR /root
RUN chmod -R 777 /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 5432
CMD [""]
