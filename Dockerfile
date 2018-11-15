FROM ubuntu:14.04
MAINTAINER Cameron <chenkan@gs-robot.com>

ADD install_scripts.tar.gz /root/

# install bazel and it's dependencies
RUN cd /root \
  && ./pre_install.sh && rm pre_install.sh \
  && ./install_bazel.sh && rm install_bazel.sh

WORKDIR /root

CMD ["/bin/bash"]
