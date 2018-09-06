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

ARG PINPOINT_VERSION=${PINPOINT_VERSION:-1.7.3}
ARG INSTALL_URL=https://github.com/naver/pinpoint/releases/download/${PINPOINT_VERSION}/pinpoint-agent-${PINPOINT_VERSION}.tar.gz

COPY configure-agent.sh /usr/local/bin/

RUN apk add --update curl bash \
    && chmod a+x /usr/local/bin/configure-agent.sh \
    && mkdir -p /pinpoint-agent \
    && chmod -R o+x /pinpoint-agent \
    && curl -SL ${INSTALL_URL} -o pinpoint-agent.tar.gz \
    && gunzip pinpoint-agent.tar.gz \
    && tar -xf pinpoint-agent.tar -C /pinpoint-agent \
    && rm pinpoint-agent.tar \
    && apk del curl \
    && rm /var/cache/apk/*

VOLUME ["/pinpoint-agent"]

ENTRYPOINT ["/usr/local/bin/configure-agent.sh"]
CMD ["tail", "-f", "/dev/null"]
