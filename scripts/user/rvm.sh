#!/bin/bash

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3;
echo "*************************"
echo "BEGIN installation of RVM"
cd /home/vagrant && curl -L get.rvm.io | bash -s stable --rails;
echo "FINISHED installation of RVM"
echo "****************************"
cd /home/vagrant && source ~/.rvm/scripts/rvm;
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc;

rvm -v
ruby -v
rails -v

# Install node.js
echo "*****************************"
echo "BEGIN installation of node.js"
mkdir /home/vagrant/node;
git clone https://github.com/joyent/node.git /home/vagrant/node;
cd /home/vagrant/node && ./configure;
cd /home/vagrant/node && make;
cd /home/vagrant/node && make test; # pseudoRandomBytes error
cd /home/vagrant/node && sudo make install;
echo "FINISHED installation of node.js"
echo "********************************"

rvm -v
ruby -v
rails -v
