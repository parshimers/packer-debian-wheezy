#!/bin/bash

# REFERENCES:
# http://seanh.cc/posts/fix-postgresql-locale-on-vagrant/
# https://github.com/a2labs/vagrant-rails/blob/master/setup.sh
# https://github.com/jackdb/pg-app-dev-vm

# Edit the following to change the version of PostgreSQL that is installed
PG_VERSION=9.1

# LANGUAGE SETTINGS
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

# INSTALL POSTGRESQL
echo "INSTALL PostgreSQL"
apt-get install -y postgresql-$PG_VERSION postgresql-contrib-$PG_VERSION
pg_dropcluster $PG_VERSION main --stop
pg_createcluster $PG_VERSION main --start
sudo -u postgres psql -l

# Configure PostgreSQL so that database is accessible from the host
echo "CONFIGURE PostgreSQL"
PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Append to pg_hba.conf to add password auth:
echo "host    all             all             all                     md5" >> "$PG_HBA"

# Explicitly set default client_encoding
echo "client_encoding = utf8" >> "$PG_CONF"

# Restart so that all new config is loaded:
service postgresql restart
