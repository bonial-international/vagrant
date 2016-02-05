# Vagrant config files to quickly get up to speed with Puppet

## Install Vagrant on your workstation

This is out of scope here, have a look at the [official documentation](https://www.vagrantup.com/docs/installation/).

Before proceeding, you should be able to execute this command successfully:

	$ vagrant --version

## Clone this repo somewhere on your local workstation

	$ git clone https://github.com/bonial/vagrant.git
	$ cd vagrant
	(in vagrant dir) $ vagrant up

## Drop Puppet modules in modules/ subfolder

For example:

	(in vagrant dir) $ git clone https://github.com/bonial/ntp.git modules/ntp

## Edit site.pp to include them

For example:

	(in vagrant dir) $ echo 'include ntp' >> site.pp

## Run provision any time you want to apply your changes

	(in vagrant dir) $ vagrant provision
