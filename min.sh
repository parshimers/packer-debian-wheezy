#!/bin/bash

rm -rf output-virtualbox-iso
mkdir archive
rm archive/debian-wheezy-rvm.box
mv debian-wheezy-rvm.box archive/debian-wheezy-rvm.box
mkdir log
DATE=`date +%Y%m%d_%H%M%S`
packer build debian-wheezy.json 2>&1 | tee log/packer-$DATE.txt

vagrant package --base vagrant-debian-wheezy # Produces Vagrant box

sh vagrant.sh # Copies the Vagrant box to the Vagrant setup
