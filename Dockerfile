FROM ubuntu:14.04
MAINTAINER Cameron <chenkan@gs-robot.com>

# set timezone
RUN echo Asia/Shanghai > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

ADD install_scripts.tar.gz /root/

# install bazel and it's dependencies
RUN cd /root \
  && chmod +x install_java.sh && chmod +x install_bazel.sh \
  && ./install_java.sh && ./install_bazel.sh \
  && rm install_java.sh && rm install_bazel.sh

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV BAZEL_BIN=/root/bin
ENV PATH=$PATH:$BAZEL_BIN

WORKDIR /root

CMD ["/bin/bash"]
