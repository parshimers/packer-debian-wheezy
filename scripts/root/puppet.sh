#!/bin/bash

# Prepare puppetlabs repo
apt-get install -y wget
wget http://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
dpkg -i puppetlabs-release-wheezy.deb
apt-get -y update

# Install puppet
apt-get -y install puppet facter

# Cleanup
rm -f puppetlabs-release-wheezy.deb
