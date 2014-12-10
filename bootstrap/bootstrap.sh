#!/bin/bash

echo $(hostname -f)


if [[ $(grep -c "# Local hosts" /etc/hosts) -eq 0 ]]; then 
	cat /vagrant/bootstrap/hosts >> /etc/hosts
fi

. /etc/lsb-release

sed -e "s/trusty/${DISTRIB_CODENAME}/" /vagrant/bootstrap/sources.list > /etc/apt/sources.list
DEB=$(echo "http://apt.puppetlabs.com/puppetlabs-release-trusty.deb" | sed -e "s/trusty/${DISTRIB_CODENAME}/")
wget $DEB -O /tmp/puppetlabs.deb
dpkg -i /tmp/puppetlabs.deb

apt-get clean
apt-get update
apt-get -y install vim-nox language-pack-en git puppet
locale-gen UTF-8

