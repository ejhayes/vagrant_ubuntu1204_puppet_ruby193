# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Vagrant Client Name Service Broken
  # http://askubuntu.com/questions/238040/how-do-i-fix-name-service-for-vagrant-client
  # https://bugs.launchpad.net/ubuntu/+source/virtualbox/+bug/1048783
  #
  # This is a known issue in Ubuntu 12.10 where name resolution is broken
  # the following modifications fix the issue
  config.vm.provider :virtualbox do |v|
    # This setting makes it so that network access from inside the vagrant guest
    # is able to resolve DNS using the hosts VPN connection.
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # Agent forwarding does not work by default
  # When provisioning a system.  This part should be
  # Kept as is and not consolidated elsewhere.
  config.ssh.forward_agent = true
  config.vm.provision :shell do |shell|
      shell.inline = "touch $1 && chmod 0440 $1 && echo $2 > $1"
      shell.args = %q{/etc/sudoers.d/root_ssh_agent "Defaults    env_keep += \"SSH_AUTH_SOCK\""}
  end

  # Bootstrap the box
  config.vm.provision :shell do |s|
    s.path = "packaging/vagrant/bootstrap.sh"
  end
end
