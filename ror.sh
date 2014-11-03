#!/bin/bash

rm -rf output-virtualbox-iso
mkdir archive
rm archive/debian-wheezy-rvm.box
mv debian-wheezy.box archive/debian-wheezy.box
mkdir log
DATE=`date +%Y%m%d_%H%M%S`
packer build debian-wheezy-rvm.json 2>&1 | tee log/packer-rvm-$DATE.txt

vagrant package --base vagrant-debian-wheezy-rvm # Produces Vagrant box

sh vagrant-rvm.sh # Copies the Vagrant box to the Vagrant setup
