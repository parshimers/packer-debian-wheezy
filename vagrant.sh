#!/bin/bash

# Clones the vagrant_debian_wheezy repository 
# and copies the Vagrant box to it

git clone https://github.com/jhsu802701/vagrant_debian_wheezy.git
rm vagrant_debian_wheezy/debian-wheezy.box
cp debian-wheezy.box vagrant_debian_wheezy_rvm/debian-wheezy.box
