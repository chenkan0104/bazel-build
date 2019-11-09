FROM ubuntu:16.04
MAINTAINER Cameron <chenkan@gs-robot.com>

ADD install.sh /root/
ADD sources.list /root/

# run install.sh
RUN cd /root && ./install.sh && rm install.sh

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /root

CMD ["/bin/bash"]
