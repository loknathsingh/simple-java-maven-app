FROM openjdk:8u212-jre-alpine3.9
RUN apk update && apk add  curl
RUN adduser abc
RUN mkdir -p /home/abc

COPY --chown=1000:1000 ./target/*.jar /home/abc/
CMD[""java","-Xmx1024m","-jar","*.jar""]       
