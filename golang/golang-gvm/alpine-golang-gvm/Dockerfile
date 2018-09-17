# Build a minimal distribution container
# upstream https://github.com/gliderlabs/docker-alpine
FROM alpine:3.8
MAINTAINER 若虚 <slpcat@qq.com>

# Container variables
ENV \
    TERM="xterm" \
    LANG="en_US.UTF-8" \ 
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    TIMEZONE="Asia/Shanghai"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

# Set timezone and locales
RUN set -ex \
    && apk update \
    && apk upgrade \
    && apk add \
           bash \
           tzdata \
           vim \
           tini \
           su-exec \
           gzip \
           tar \
           wget \
           curl \
    && echo "${TIMEZONE}" > /etc/TZ \
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    # Network fix
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

#install gvm
RUN apk add git binutils bison gcc make go musl-dev openssl
RUN \
    curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer|bash \
    && source /root/.gvm/scripts/gvm \
    && gvm install go1.8 \
    && gvm install go1.9 \
    && gvm install go1.10 \
    && gvm install go1.11 \
    && gvm go1.10 --default

CMD ["/bin/bash"]
