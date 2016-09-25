
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "10.111.0.10"

  config.vm.provider "virtualbox" do |vb|
     vb.cpus = "2"
     vb.memory = "4096"
  end

  config.vm.provision "docker"
  config.vm.provision "shell", inline: "cd /vagrant && make vagrant"
end
