# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.hostname = "automate"
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell",
    run: "always",
    inline: "/vagrant/scripts/vagrant_bootstrap.sh",
    privileged: false

end
