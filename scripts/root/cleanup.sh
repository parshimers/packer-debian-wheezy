#!/bin/bash

# Install zerofree
apt-get install -y zerofree;

# Clean up
apt-get -y clean;
rm -rf /usr/share/doc;
find /var/cache -type f -exec rm -rf {} \;
find /usr/share/locale/* -maxdepth 1 -type d ! -name "en*" -exec rm -rf {} \;

# Clean up guest additions (no longer needed by VirtualBox)
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?;
rm -rf /usr/src/virtualbox-ose-guest*;
rm -rf /usr/src/vboxguest*;

# Clean up Linux headers
rm -rf /usr/src/linux-headers*;
rm -rf /usr/src/linux;

# Remove history file
unset HISTFILE;
rm ~/.bash_history /home/vagrant/.bash_history;

# Use zerofree to zero out unused space
echo "Using zerofree to zero out unused space"
init 1;
mount -o remount,ro /dev/sda1;
zerofree /dev/sda1; # Takes time
echo "Finished using zerofree to zero out unused space"

# sync data to disk (fix packer)
echo "Begin sync"
sync;
echo "Finished sync"
echo
echo "FINISHED CLEANUP"
