FROM ubuntu:16.04

# Update, Install Prerequisites
RUN apt-get -y update && \
    apt-get install -y sudo wget perl gcc g++ make automake libtool autoconf \
        m4 gcc-multilib language-pack-en-base software-properties-common \
        python-software-properties && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Setup User
RUN useradd -d /data -s /bin/bash --uid 1000 minecraft

# Stage Files
COPY server.properties /data/server.properties
COPY start.sh /start.sh
RUN chmod 0755 /start.sh

# Setup container
EXPOSE 19132
VOLUME ["/data"]
WORKDIR /data

# Start Pocketmine
CMD ["/start.sh"]
