#!/bin/bash

# Clones the vagrant_debian_wheezy_rvm repository 
# and copies the Vagrant box to it

git clone https://github.com/jhsu802701/vagrant_debian_wheezy_rvm.git
rm vagrant_debian_wheezy_rvm/debian-wheezy-rvm.box
cp debian-wheezy-rvm.box vagrant_debian_wheezy_rvm/debian-wheezy-rvm.box
