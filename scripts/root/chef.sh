#!/bin/bash

apt-get install -y curl
curl -L https://www.opscode.com/chef/install.sh | sudo bash;
rm -f /tmp/chef*deb;
