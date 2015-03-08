#!/bin/bash

# Install RVM (Ruby on Rails)
echo "*************************"
echo "BEGIN installation of RVM"
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
cd /home/vagrant && \curl -sSL https://get.rvm.io | bash -s stable --ruby --rails

echo "FINISHED installation of RVM"
echo "****************************"

# Install NVM (node.js)
echo "*****************************"
echo "BEGIN installation of node.js"
git clone https://github.com/creationix/nvm.git /home/vagrant/.nvm
cd /home/vagrant/.nvm && git checkout `git describe --abbrev=0 --tags`
echo "FINISHED installation of node.js"
echo "********************************"

echo
echo "******************************"
echo "BEGIN setting up Node and Ruby"
echo
echo "Activating NVM and then RVM at startup"
echo "RVM must be activated SECOND."
echo "This ensures that the $PATH environmental variable lists the path"
echo "to RVM first.  If the first portion of the $PATH environmental"
echo "variable does NOT point to RVM, a PATH error results."
. ~/.nvm/nvm.sh # Activate NVM
echo ". ~/.nvm/nvm.sh" >> ~/.bashrc; # Activate NVM at startup
nvm --version # Display the installed version of NVM
nvm install stable # Install latest stable version of node.js
nvm use stable # Activate latest stable version of node.js
node -v # Display the version number of Ruby
NODE_VERSION="$(node -v)" # Get the version number of node.js
echo "nvm use ${NODE_VERSION}" >> ~/.bashrc; # Activate node.js at startup

cd /home/vagrant && source ~/.rvm/scripts/rvm; # Activate RVM
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc; # Activate RVM at startup
rvm -v # Show installed version of RVM
rvm install ruby --latest # Install the latest stable version of Ruby
rvm install ruby 2.0.0 # Install Ruby 2.0.0 (used in many projects)
rvm use ruby --latest # Set the latest stable version of Ruby as the default
ruby -v # Display the version number of Ruby
rails -v # Get the version number of Ruby

# Must provide this path to the path variable to avoid getting an error
# message
echo "PATH=/home/vagrant/.rvm/gems/$RUBY_VERSION/bin:$PATH" >> ~/.bashrc;

wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh # Install Heroku Toolbelt

echo "FINISHED setting up Node and Ruby"
echo "*********************************"
