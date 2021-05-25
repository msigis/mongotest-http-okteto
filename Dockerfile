# Auto Generated Dockerfile
FROM ballerina/jre11:v1

LABEL maintainer="dev@ballerina.io"

COPY bcpkix-jdk15on-1.61.jar /home/ballerina/jars/ 
COPY io-native-0.6.0-alpha8.jar /home/ballerina/jars/ 
COPY testng-6.14.3.jar /home/ballerina/jars/ 
COPY netty-tcnative-boringssl-static-2.0.31.Final.jar /home/ballerina/jars/ 
COPY mongodb.jar /home/ballerina/jars/ 
COPY netty-transport-4.1.50.Final.jar /home/ballerina/jars/ 
COPY task-native-2.0.0-alpha9.jar /home/ballerina/jars/ 
COPY mime.jar /home/ballerina/jars/ 
COPY testng-6.14.3.jar /home/ballerina/jars/ 
COPY mimepull-1.9.11.jar /home/ballerina/jars/ 
COPY time-native-2.0.0-alpha9.jar /home/ballerina/jars/ 
COPY cache.jar /home/ballerina/jars/ 
COPY auth.jar /home/ballerina/jars/ 
COPY mime-native-1.1.0-alpha8.jar /home/ballerina/jars/ 
COPY bcprov-jdk15on-1.61.jar /home/ballerina/jars/ 
COPY jakarta.activation-1.2.2.jar /home/ballerina/jars/ 
COPY io.jar /home/ballerina/jars/ 
COPY file-native-0.7.0-alpha8.jar /home/ballerina/jars/ 
COPY http-native-1.1.0-alpha8.jar /home/ballerina/jars/ 
COPY netty-handler-proxy-4.1.50.Final.jar /home/ballerina/jars/ 
COPY os-native-0.8.0-alpha8.jar /home/ballerina/jars/ 
COPY bcprov-jdk15on-1.61.jar /home/ballerina/jars/ 
COPY ballerina-observability-2.0.0-alpha8-20210423-135000-530658ec.jar /home/ballerina/jars/ 
COPY jwt-native-1.1.0-alpha8.jar /home/ballerina/jars/ 
COPY quartz-2.3.1.jar /home/ballerina/jars/ 
COPY mimepull-1.9.11.jar /home/ballerina/jars/ 
COPY snakeyaml-1.26.0.wso2v1.jar /home/ballerina/jars/ 
COPY netty-resolver-4.1.50.Final.jar /home/ballerina/jars/ 
COPY ballerina-rt-2.0.0-alpha8-20210423-135000-530658ec.jar /home/ballerina/jars/ 
COPY netty-codec-4.1.50.Final.jar /home/ballerina/jars/ 
COPY netty-codec-http2-4.1.50.Final.jar /home/ballerina/jars/ 
COPY jwt.jar /home/ballerina/jars/ 
COPY cloud.jar /home/ballerina/jars/ 
COPY oauth2.jar /home/ballerina/jars/ 
COPY netty-buffer-4.1.50.Final.jar /home/ballerina/jars/ 
COPY time.jar /home/ballerina/jars/ 
COPY os.jar /home/ballerina/jars/ 
COPY crypto-native-1.1.0-alpha8.jar /home/ballerina/jars/ 
COPY org.wso2.transport.local-file-system-6.0.55.jar /home/ballerina/jars/ 
COPY http.jar /home/ballerina/jars/ 
COPY netty-common-4.1.50.Final.jar /home/ballerina/jars/ 
COPY crypto.jar /home/ballerina/jars/ 
COPY regex.jar /home/ballerina/jars/ 
COPY observe.jar /home/ballerina/jars/ 
COPY netty-handler-4.1.50.Final.jar /home/ballerina/jars/ 
COPY auth-native-1.1.0-alpha8.jar /home/ballerina/jars/ 
COPY file.jar /home/ballerina/jars/ 
COPY mongotest_http.jar /home/ballerina/jars/ 
COPY netty-codec-http-4.1.50.Final.jar /home/ballerina/jars/ 
COPY task.jar /home/ballerina/jars/ 
COPY observe.jar /home/ballerina/jars/ 
COPY ballerina-observability-internal-2.0.0-alpha8-20210423-135000-530658ec.jar /home/ballerina/jars/ 
COPY mime-native-1.1.0-alpha8.jar /home/ballerina/jars/ 
COPY commons-pool-1.5.6.wso2v1.jar /home/ballerina/jars/ 
COPY log.jar /home/ballerina/jars/ 
COPY oauth2-native-1.1.0-alpha8.jar /home/ballerina/jars/ 
COPY io-native-0.6.0-alpha8.jar /home/ballerina/jars/ 
COPY cache-native-2.1.0-alpha8.jar /home/ballerina/jars/ 
COPY log-native-1.1.0-alpha8.jar /home/ballerina/jars/ 
COPY bcpkix-jdk15on-1.61.jar /home/ballerina/jars/ 
COPY mongo-utils-2.0.7.jar /home/ballerina/jars/ 
RUN addgroup troupe \
    && adduser -S -s /bin/bash -g 'ballerina' -G troupe -D ballerina \
    && apk add --update --no-cache bash \
    && chown -R ballerina:troupe /usr/bin/java \
    && rm -rf /var/cache/apk/*

WORKDIR /home/ballerina
COPY mongotest_http.jar /home/ballerina

EXPOSE  9090
USER ballerina

CMD java -Xdiag -cp "mongotest_http.jar:jars/*" 'marco/mongotest_http/0_1_0/$_init'
