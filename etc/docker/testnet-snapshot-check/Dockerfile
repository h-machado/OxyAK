#Build docker image with:
# $ docker build -t oxy:testnetsnapshotcheck .
#Test snapshot example:
# $ docker run oxy:testnetsnapshotcheck
# ######################################################################## 100.0%
# {"timestamp":"2017-07-19T14:00:23+0000", "success":true, "msg": "Blockchain snapshot downloaded"}
# {"timestamp":"2017-07-19T14:00:24+0000", "height":125644, "upto":125645, "success":true, "msg": "Blockchain loaded and oxynode running"}

FROM ubuntu:latest

RUN apt -y update && apt-get install -y curl build-essential python lsb-release wget openssl autoconf libtool automake libsodium-dev git sudo xz-utils locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

RUN useradd -m -p `perl -e 'printf("%s\n", crypt($ARGV[0], "password"))' oxy` -s /bin/bash oxy
RUN usermod -aG sudo oxy
RUN echo oxy ALL=\(ALL\) NOPASSWD: ALL > /etc/sudoers.d/oxy


RUN mkdir -p /path/to
RUN chown -R oxy /path

USER oxy
WORKDIR /home/oxy
RUN git clone -b testnet https://github.com/oxycoin/oxy-node.git && oxy-node/oxy_manager.bash install

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
COPY ./test-snapshot.sh /home/oxy
ENTRYPOINT timeout 120 ./test-snapshot.sh
