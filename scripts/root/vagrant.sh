#!/bin/bash

# Add time stamp
DATE=`date +%Y_%m%d_%H%M`
echo "$DATE" >> /home/vagrant/timestamp.txt

# Add shared directory
mkdir /home/vagrant/shared
echo "Welcome to the Debian Wheezy Vagrant box!" >> /home/vagrant/shared/README-guest.txt
echo "If you can read this message from your host OS, " >> /home/vagrant/shared/README-guest.txt
echo "you have confirmation that file syncing works." >> /home/vagrant/shared/README-guest.txt

apt-get update # Update list of available packages
apt-get upgrade # Install the newest versions of packages already installed

apt-get install -y build-essential

# Build the latest Debian kernels
apt-get install -y module-assistant 
module-assistant prepare

# Set up SSH
apt-get install -y openssh-server
echo "UseDNS no" >> /etc/ssh/sshd_config # Speed up the login process
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config # Speed up the login process

# Network configurations
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm /lib/udev/rules.d/75-persistent-net-generator.rules
rm -rf /dev/.udev/ /var/lib/dhcp/*
echo "pre-up sleep 2" >> /etc/network/interfaces

# Set up sudo
apt-get install -y sudo
# Set up password-less sudo for user vagrant
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant
chmod 440 /etc/sudoers.d/vagrant
/etc/init.d/sudo restart

# Set up keys
mkdir -p /home/vagrant/.ssh
wget 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chown -Rf vagrant. /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys

# Install VirtualBox guest additions
mkdir /tmp/vbox;
VER=$(cat /home/vagrant/.vbox_version);
mount -o loop /home/vagrant/VBoxGuestAdditions_$VER.iso /tmp/vbox;
yes | sh /tmp/vbox/VBoxLinuxAdditions.run;
umount /tmp/vbox;
rmdir /tmp/vbox;
rm /home/vagrant/*.iso;
ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions;
