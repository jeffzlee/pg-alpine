FROM alpine:edge
MAINTAINER @JeffZLee https://github.com/jeffzlee


RUN apk update && \
addgroup postgres postgres

#RUN apk update && \
#apk add wget dpkg gnupg

ENV GOSU_VERSION="1.7" \
GOSU_ARCHITECTURE="amd64"
ENV GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$GOSU_ARCHITECTURE" \
GOSU_DOWNLOAD_SIG="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$GOSU_ARCHITECTURE.asc" \
GOSU_DOWNLOAD_KEY="0x036A9C25BF357DD4"
RUN buildDeps='curl gnupg' HOME='/root' \
    && set -x \
    && apk add --update $buildDeps \
    # && gpg-agent --daemon \
    && gpg --keyserver pgp.mit.edu --recv-keys $GOSU_DOWNLOAD_KEY \
    && echo "trusted-key $GOSU_DOWNLOAD_KEY" >> /root/.gnupg/gpg.conf \
    && curl -sSL "$GOSU_DOWNLOAD_URL" > gosu-$GOSU_ARCHITECTURE \
    && curl -sSL "$GOSU_DOWNLOAD_SIG" > gosu-$GOSU_ARCHITECTURE.asc \
    && gpg --verify gosu-$GOSU_ARCHITECTURE.asc \
    && rm -f gosu-$GOSU_ARCHITECTURE.asc \
    && mv gosu-$GOSU_ARCHITECTURE /usr/bin/gosu \
    && chmod +x /usr/bin/gosu \
    && gosu nobody true \
    && apk del --purge $buildDeps \
    && rm -rf /root/.gnupg \
    && rm -rf /var/cache/apk/* \
    ;


# 036A9C25BF357DD4 - Tianon Gravi <tianon@tianon.xyz> 
# http://pgp.mit.edu/pks/lookup?op=vindex&search=0x036A9C25BF357DD4 

ADD . /code
WORKDIR /code
RUN chmod -R 777 /code
COPY docker-entrypoint.sh  /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 5432
CMD [""]
