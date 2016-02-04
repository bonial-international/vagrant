#!/bin/bash
set -e
CACHE_UPDATED=
export PATH="${PATH}:/opt/puppetlabs/bin"

update_apt_cache (){
	local force="$1"
	if [ -n "$force" -o "$CACHE_UPDATED" != 'y' ]; then
		apt-get update
		CACHE_UPDATED='y'
	fi
}

install_lsbrelease() {
	if ! lsb_release > /dev/null 2> /dev/null; then
		update_apt_cache
		apt-get install -y lsb-release
	fi
}

purge_puppet2() {
	if puppet --version | grep -q ^2; then
		update_apt_cache
		apt-get purge -y puppet puppet-common
	fi
}

install_puppet4() {
	install_lsbrelease
	purge_puppet2

	if ! which puppet > /dev/null; then
		local release=$(lsb_release --codename | awk '{print $2}')
		wget --no-check-certificate "https://apt.puppetlabs.com/puppetlabs-release-pc1-${release}.deb"
		dpkg -i puppetlabs-release-pc1-${release}.deb
		update_apt_cache force
		apt-get install -y puppet-agent
		rm "puppetlabs-release-pc1-${release}.deb"*
	fi
}

run_puppet() {
	puppet apply \
		--modulepath=/vagrant/modules/ \
		/vagrant/site.pp
}

main() {
	install_puppet4
	run_puppet
}

main
