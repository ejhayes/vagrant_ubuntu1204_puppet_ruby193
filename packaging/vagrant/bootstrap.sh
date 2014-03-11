#!/usr/bin/env bash

# Where is stuff located?
PUPPET_DIR=/etc/puppet
VAGRANT_HOME=/home/vagrant
VAGRANT_SHARED=/vagrant
PUPPET_PACKAGING_DIR=$VAGRANT_SHARED/packaging/vagrant

# Useful commands we use
RUN_PUPPET=$VAGRANT_HOME/run_puppet
BOOTSTRAP=$PUPPET_PACKAGING_DIR/manifests/bootstrap.pp

# Ubuntu puppet repositories are not up to date
echo '############ ADDING OFFICIAL PUPPET REPOSITORY ############'
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb

# Install base bootstrapping dependencies
echo '############ INSTALLING BASE DEPENDENCIES ############'
# Install base bootstrapping dependencies
echo '############ INSTALLING BASE DEPENDENCIES ############'
apt-get update
apt-get -y install python-software-properties
apt-add-repository -y ppa:brightbox/ruby-ng
apt-get update

# http://askubuntu.com/questions/146921/how-do-i-apt-get-y-dist-upgrade-without-a-grub-config-prompt
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

apt-get -y install git curl puppet ruby1.9.3 rubygems rake vim

# http://ubuntuforums.org/showthread.php?t=971693
perl -pi -e 's/(hosts:\s+)(.+)$/$1files mdns4_minimal [NOTFOUND=return] dns mdns4/' /etc/nsswitch.conf

# Install bundler since it is needed
echo '############ INSTALLING BUNDLER ############'
gem install bundler --no-ri --no-rdoc
gem install librarian-puppet --no-ri --no-rdoc

# Default web directory
mkdir -p /var/www
