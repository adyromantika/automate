# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.hostname = "automate"
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "public_network", bridge: "Intel(R) Dual Band Wireless-AC 7265"
  config.vm.provision "shell",
    run: "always",
    inline: "/vagrant/scripts/vagrant_bootstrap.sh #{ENV['VAR1']}",
    privileged: false

end
