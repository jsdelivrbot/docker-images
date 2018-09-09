FROM webdevops/php:ubuntu-16.04
MAINTAINER 若虚 <slpcat@qq.com>

# Container variables
ENV \
    TERM="xterm" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    TIMEZONE="Asia/Shanghai"

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list

# Set timezone and locales
RUN \
    echo "${TIMEZONE}" > /etc/timezone \
    && echo "$LANG UTF-8" > /etc/locale.gen \
    && apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq apt-utils dialog vim-tiny curl locales \
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && update-locale LANG=$LANG \
    && locale-gen $LANG \
    && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install required packages
RUN \
    apt-get dist-upgrade -y
ENV WEB_DOCUMENT_ROOT=/app \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.vm \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET=""
ENV WEB_PHP_SOCKET=127.0.0.1:9000

COPY conf/ /opt/docker/

RUN git clone https://github.com/naver/pinpoint-c-agent.git

ENV AGENT_ID="k8s-php" \
    AGENT_TYPE="PHP" \
    APP_NAME="php-demo" \
    COLLECTOR_IP="pinpoint-collector-headless" \
    COLLECTOR_TCP_PORT="9994" \
    COLLECTOR_STAT_PORT="9995" \
    COLLECTOR_SPAN_PORT="9996" \
    LOGLEVEL="INFO" \
    LOGFILE_ROOTPATH="\/tmp" \
    PLUGIN_ROOTDIR="\/app\/pinpoint_plugins"

#install pinpoint php module
#COPY --from=build  /root/pinpoint-c-agent/pinpoint_php/modules/pinpoint.so /usr/lib64/php/modules/
COPY pinpoint-ubuntu16.04-php-7.0.30.so /usr/lib/php/20151012/pinpoint.so
RUN echo 'extension=pinpoint.so' > /opt/docker/etc/php/conf.d/pinpoint.ini \
    && echo 'pinpoint_agent.config_full_name=/etc/pinpoint_agent.conf' >> /opt/docker/etc/php/conf.d/pinpoint.ini

RUN cp /pinpoint-c-agent/quickstart/config/pinpoint_agent.conf.example  /etc/pinpoint_agent.conf
#install pinpoint plugins
RUN mkdir -p /app/pinpoint_plugins && cp /pinpoint-c-agent/quickstart/php/web/plugins/* /app/pinpoint_plugins
#copy sample website source code
RUN cp /pinpoint-c-agent/quickstart/php/web/*.php /app

RUN set -x \
    # Install nginx
    && apt-install \
        nginx \
    && docker-run-bootstrap \
    && docker-image-cleanup

EXPOSE 80 443
