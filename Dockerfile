FROM ubuntu:16.04
MAINTAINER Cameron <chenkan@gs-robot.com>

ADD install.sh /root/install.sh
ADD sources.list.16.04 /root/sources.list

# run install.sh
RUN cd /root && ./install.sh && rm install.sh

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /root

CMD ["/bin/bash"]
