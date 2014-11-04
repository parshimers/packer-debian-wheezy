packer-debian-wheezy
====================

This repository contains the Packer configuration to generate Debian Stable Vagrant boxes.

Usage
-----
To create a Vagrant box, use Git to clone this source code, cd your way into this project's root path, and run the 
appropriate box generating script.  At the end of the process, a Vagrant box will be created, and the appropriate 
Vagrant setup will be cloned here.  Open a second Terminal window or tab, cd your way into the Vagrant setup, and 
enter the command "sh install_new_box.sh" to install and log in to the new Vagrant box.

Debian Wheezy (Minimal)
-----------------------
Box generating script: min.sh
<br>
Vagrant Cloud URL: https://vagrantcloud.com/jhsu802701/boxes/debian-wheezy
<br>
Vagrant setup served: https://github.com/jhsu802701/vagrant_debian_wheezy

Debian Wheezy With RVM
----------------------
Box generating script: ror.sh
<br>
Vagrant Cloud URL: https://vagrantcloud.com/jhsu802701/boxes/debian-wheezy-rvm
<br>
Vagrant setup served: https://github.com/jhsu802701/vagrant_debian_wheezy_rvm
