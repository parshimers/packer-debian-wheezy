#!/bin/bash

# Install RVM prerequisites

apt-get install -y git curl zlib1g-dev subversion bzip2
apt-get install -y build-essential openssl libreadline6 libreadline6-dev git-core zlib1g libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison ca-certificates
apt-get install -y g++ ssh libpq-dev postgresql libgtkmm-2.4 libnotify-bin dbus
apt-get install -y python # Necessary for installing node.js
apt-get install -y redis-server # Some Rails apps use Redis
