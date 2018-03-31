#!/bin/bash

set -eux

cp /server.properties /data/server.properties

wget -q -O /data/install.sh https://get.pmmp.io
chmod 0755 /data/install.sh
wget -q -O /data/php-linux-x86-64.tar.gz https://jenkins.pmmp.io/job/PHP-7.2-Linux-x86_64/lastSuccessfulBuild/artifact/PHP_Linux-x86_64.tar.gz

cd /data
./install.sh -r -v development
tar -zxf ./php-linux-x86-64.tar.gz --no-same-owner
rm -f /data/install.sh /data/php-linux-x86-64.tar.gz

# start pocketmine
exec ./start.sh
