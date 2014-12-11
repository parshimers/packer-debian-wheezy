#!/bin/bash

# Install RVM (Ruby on Rails)
echo "*************************"
echo "BEGIN installation of RVM"
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
cd /home/vagrant && \curl -sSL https://get.rvm.io | bash -s stable --ruby --rails
rvm -v
cd /home/vagrant && source ~/.rvm/scripts/rvm;
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc;
echo "FINISHED installation of RVM"
echo "****************************"

# Install NVM (node.js)
echo "*****************************"
echo "BEGIN installation of node.js"
cd /home/vagrant && curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash
source ~/.nvm/nvm.sh
echo "source ~/.nvm/nvm.sh" >> ~/.bashrc;
echo "FINISHED installation of node.js"
echo "********************************"

echo "******************************"
echo "BEGIN setting up Node and Ruby"

# Set up Node first and Ruby second.
# This ensures that the $PATH environmental variable lists the path to
# RVM first.  If the first portion of the $PATH environmental variable 
# does NOT point to RVM, a PATH error results.
nvm --version
nvm install stable
nvm use stable
node -v

rvm install ruby --latest
rvm install ruby 2.0.0
rvm use ruby --latest
ruby -v
rails -v
echo "FINISHED setting up Node and Ruby"
echo "*********************************"
