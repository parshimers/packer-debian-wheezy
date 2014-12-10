#!/bin/bash

# Install RVM (Ruby on Rails)
echo "*************************"
echo "BEGIN installation of RVM"
command curl -sSL https://rvm.io/mpapis.asc | gpg --import - # Provides the necessary key
cd /home/vagrant && \curl -sSL https://get.rvm.io | bash -s stable --ruby --rails
rvm -v
cd /home/vagrant && source ~/.rvm/scripts/rvm;
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc;
rvm use ruby
ruby -v
echo "FINISHED installation of RVM"
echo "****************************"

# Install NVM (node.js)
echo "*****************************"
echo "BEGIN installation of node.js"
cd /home/vagrant && curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash
source ~/.profile
nvm --version
nvm use stable
node -v
echo "FINISHED installation of node.js"
echo "********************************"
