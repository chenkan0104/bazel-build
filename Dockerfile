FROM ubuntu:16.04
MAINTAINER Cameron <chenkan@gs-robot.com>

ADD install_scripts.tar.gz /root/

# install bazel and it's dependencies
RUN cd /root \
  && ./pre_install.sh && rm pre_install.sh \
  && ./install_java.sh && rm install_java.sh \
  && ./install_bazel.sh && rm install_bazel.sh \
  && ./install_python.sh && rm install_python.sh

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /root

CMD ["/bin/bash"]
