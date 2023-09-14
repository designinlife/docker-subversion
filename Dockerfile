FROM alpine:3.18

LABEL maintainer="Lei.Lee <web.developer.network@gmail.com>" \
    subversion.version="1.14.2"

COPY bootstrap.sh /usr/local/bin/bootstrap.sh
COPY create /usr/local/bin/create

ENV LANG "en_US.UTF-8"

RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps tzdata subversion bash curl \
    && echo "[general]" >> /etc/svnserve.conf \
    && echo "anon-access = none" >> /etc/svnserve.conf \
    && echo "auth-access = write" >> /etc/svnserve.conf \
    && echo "password-db = /var/svn/conf/passwd" >> /etc/svnserve.conf \
    && echo "authz-db = /var/svn/conf/authz" >> /etc/svnserve.conf \
    && echo "realm = Subversion" >> /etc/svnserve.conf \
    && chmod +x /usr/local/bin/create /usr/local/bin/bootstrap.sh \
    && cd ~ \
    && rm -rf ~/*

VOLUME [ "/var/svn" ]

EXPOSE 3690

ENTRYPOINT [ "bootstrap.sh" ]
