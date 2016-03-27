FROM ubuntu:14.04
MAINTAINER Cameron <chenkan@gs-robot.com>

RUN apt-get update \
  && apt-get install -y software-properties-common \
  && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

# install jdk8
RUN add-apt-repository -y ppa:webupd8team/java \
  && apt-get update \
  && apt-get install -y oracle-java8-installer \
&& rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# install curl for fetching bazel, git for fetching code
RUN apt-get install -y curl git

# install prerequisites of bazel
RUN apt-get install -y \
  pkg-config \
  zip \
  g++ \
  zlib1g-dev \
  unzip \
&& rm -rf /var/lib/apt/lists/*

RUN groupadd -r build \
  && useradd -m -g build bazel

USER bazel
WORKDIR /home/bazel

RUN curl -L \
  https://github.com/bazelbuild/bazel/releases/download/0.2.0/bazel-0.2.0-installer-linux-x86_64.sh \
  -o bazel-install.sh
RUN chmod 700 bazel-install.sh
RUN ./bazel-install.sh --user \
  && rm bazel-install.sh

ENV BAZEL_BIN=/home/bazel/bin
ENV PATH=$PATH:$BAZEL_BIN

CMD ["/bin/bash"]
