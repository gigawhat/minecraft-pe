# Minecraft PE Server
FROM ubuntu:16.04
MAINTAINER  Josh Keife <jkeife@gmail.com>

# Update, Install Prerequisites
RUN apt-get -y update && \
    apt-get install -y sudo wget perl gcc g++ make automake libtool autoconf \
                     m4 gcc-multilib language-pack-en-base \
                     software-properties-common python-software-properties && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Setup User
RUN useradd -d /data -s /bin/bash --uid 1000 minecraft

# Stage Files
COPY server.properties /data/server.properties
COPY start.sh /start.sh
RUN chmod 0755 /start.sh
#RUN /setup.sh

# install minecraft pe
RUN wget -q -O /data/install.sh https://get.pmmp.io && \
  chmod 0755 /data/install.sh && \
  wget -q -O /data/php-linux-x86-64.tar.gz https://jenkins.pmmp.io/job/PHP-7.2-Linux-x86_64/lastSuccessfulBuild/artifact/PHP_Linux-x86_64.tar.gz && \
  chown -R minecraft:minecraft /data && \
  cd /data && \
  sudo -E -u minecraft ./install.sh -v development && \
  sudo -E -u minecraft tar -zxf ./php-linux-x86-64.tar.gz && \
  rm -f /data/install.sh /data/php-linux-x86-64.tar.gz

# Setup container
EXPOSE 19132
VOLUME ["/data"]
WORKDIR /data

# Start Pocketmine
CMD ["/start.sh"]
