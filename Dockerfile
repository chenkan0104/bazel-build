FROM ubuntu:14.04
MAINTAINER Cameron <chenkan@gs-robot.com>

ADD install.sh /root/install.sh
ADD sources.list.14.04 /root/sources.list

# run install.sh
RUN cd /root && ./install.sh && rm install.sh

WORKDIR /root

CMD ["/bin/bash"]
