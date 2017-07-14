#Build docker image with:
# $ sudo docker build -t oxy-testnet .
#Run image with:
# $ docker run -it -p 9998:9998 oxy-testnet and then cd /home/oxy/oxy-node && ./oxy_manager.bash rebuild
#Remember to commit to preserve state

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
RUN cd /home/oxy/oxy-node && ./oxy_manager.bash start
RUN cd /home/oxy/oxy-node && ./oxy_manager.bash rebuild

