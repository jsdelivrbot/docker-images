FROM  slpcat/maven:alpine-all AS build
MAINTAINER 若虚 <slpcat@qq.com>

ARG PINPOINT_VERSION=${PINPOINT_VERSION:-1.7.3}

RUN apk add git libstdc++ nodejs npm nodejs-dev 

# install from source
RUN \
    git clone https://github.com/naver/pinpoint.git

WORKDIR /pinpoint
RUN \
    git checkout $PINPOINT_VERSION \
    #patch APPLICATION_NAME_MAX_LEN=64 AGENT_NAME_MAX_LEN=64
    && sed -i s/24/64/ commons/src/main/java/com/navercorp/pinpoint/common/PinpointConstants.java \
    #&& ./mvnw package install -Prelease -DskipTests=true
    && mvn package install -Dmaven.test.skip=true -Prelease

FROM slpcat/tomcat8:alpine-8.5
MAINTAINER 若虚 <slpcat@qq.com>

COPY --from=build /pinpoint/collector/target/pinpoint-collector-1.7.3.war /pinpoint-collector-1.7.3.war
RUN \
    rm -rf /usr/local/tomcat/webapps \
    && mkdir -p /usr/local/tomcat/webapps/ROOT \
    && unzip /pinpoint-collector-1.7.3.war -d /usr/local/tomcat/webapps/ROOT \
    && rm /pinpoint-collector-1.7.3.war

COPY start-collector.sh /usr/local/bin/
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/start-collector.sh"]
