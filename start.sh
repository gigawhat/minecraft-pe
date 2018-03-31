#!/bin/bash

set -eux

wget -q -O /data/install.sh https://get.pmmp.io
chmod 0755 /data/install.sh
wget -q -O /data/php-linux-x86-64.tar.gz https://jenkins.pmmp.io/job/PHP-7.2-Linux-x86_64/lastSuccessfulBuild/artifact/PHP_Linux-x86_64.tar.gz
chown -R minecraft:minecraft /data

cd /data
sudo -E -u minecraft ./install.sh -v development
sudo -E -u minecraft tar -zxf ./php-linux-x86-64.tar.gz
rm -f /data/install.sh /data/php-linux-x86-64.tar.gz

# start pocketmine
exec sudo -E -u minecraft ./start.sh
