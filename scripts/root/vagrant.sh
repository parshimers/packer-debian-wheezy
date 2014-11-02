#!/bin/bash

# Add time stamp
DATE=`date +%Y_%m%d_%H%M`
echo "$DATE" >> /home/vagrant/timestamp.txt

# Add shared directory
mkdir /home/vagrant/shared
chmod 700 /home/vagrant/shared

echo "********************"
echo "BEGIN apt-get update"
apt-get update -y # Update list of available packages
echo "FINISHED apt-get update"
echo "***********************"

echo "*********************"
echo "BEGIN apt-get upgrade"
apt-get upgrade -y # Install the newest versions of packages already installed
echo "FINISHED apt-get upgrade"
echo "************************"

apt-get install -y build-essential

# Build the latest Debian kernels
echo "**********************"
echo "BEGIN module-assistant"
apt-get install -y module-assistant 
module-assistant prepare
echo "FINISHED module-assistant"
echo "*************************"

# Not preinstalling the Linux headers means having to install them upon startup
echo "******************************"
echo "BEGIN installing Linux headers"
apt-get install -y linux-headers-$(uname -r)
echo "FINISHED installing Linux headers"
echo "*********************************"


# Set up SSH
echo "UseDNS no" >> /etc/ssh/sshd_config # Speed up the login process
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config # Speed up the login process

# Set up password-less sudo for user vagrant
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant
chmod 440 /etc/sudoers.d/vagrant
/etc/init.d/sudo restart

# Set up keys
echo "***********"
echo "SET UP KEYS"
apt-get install -y ca-certificates # Needed for authorized_keys to work
mkdir -p /home/vagrant/.ssh
wget 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chown -Rf vagrant. /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys
echo "FINISHED SETTING UP KEYS"
echo "************************"


# Install VirtualBox guest additions
mkdir /tmp/vbox;
VER=$(cat /home/vagrant/.vbox_version);
mount -o loop /home/vagrant/VBoxGuestAdditions_$VER.iso /tmp/vbox;
yes | sh /tmp/vbox/VBoxLinuxAdditions.run;
umount /tmp/vbox;
rmdir /tmp/vbox;
rm /home/vagrant/*.iso;
ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions;
