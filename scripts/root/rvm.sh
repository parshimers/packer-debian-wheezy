#!/bin/bash

# Install RVM prerequisites

# Provides authentication for installing curl
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3; 
apt-get install -y curl

apt-get install -y gawk
apt-get install -y git zlib1g-dev subversion bzip2
apt-get install -y build-essential openssl libreadline6 libreadline6-dev git-core zlib1g libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison ca-certificates
apt-get install -y g++ ssh libpq-dev postgresql libgtkmm-2.4 libnotify-bin dbus
apt-get install -y python # Necessary for installing node.js
apt-get install -y redis-server # Some Rails apps use Redis

# Provides authentication for installing RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3; 
