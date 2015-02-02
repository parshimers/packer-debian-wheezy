#!/bin/bash

# ADAPTED FROM https://github.com/jackdb/pg-app-dev-vm

# Edit the following to change the version of PostgreSQL that is installed
PG_VERSION=9.1

# BEGIN: GENERAL POSTGRES CONFIG

export LANGUAGE=en_US.UTF-8
echo "export LANGUAGE=en_US.UTF-8" >> /etc/bash.bashrc
export LANG=en_US.UTF-8
echo "export LANG=en_US.UTF-8" >> /etc/bash.bashrc
export LC_ALL=en_US.UTF-8
echo "export LC_ALL=en_US.UTF-8" >> /etc/bash.bashrc

echo "BEGIN locale-gen en_US.UTF-8"
locale-gen en_US.UTF-8
wait
echo "FINISHED locale-gen en_US.UTF-8"

echo '"en_US.UTF-8 UTF-8" >> /etc/locale.gen'
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen

echo "PRESEED"
echo "locales	locales/default_environment_locale	select	en_US.UTF-8" > preseed.txt
echo "locales	locales/locales_to_be_generated	multiselect	en_US ISO-8859-1, en_US.UTF-8 UTF-8" >> preseed.txt
echo "DEBCONF"
debconf-set-selections preseed.txt
rm preseed.txt
echo "DPKG-RECONFIGURE LOCALES"
dpkg-reconfigure locales -f noninteractive
wait
echo "INSTALL POSTGRESQL"

apt-get install -y postgresql-9.1
pg_dropcluster 9.1 main --stop
pg_createcluster 9.1 main --start
sudo -u postgres psql -l
