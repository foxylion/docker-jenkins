
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "10.111.0.10"

  config.vm.provider "virtualbox" do |vb|
     vb.cpus = "2"
     vb.memory = "4096"
  end

  config.vm.provision "shell", inline: 'echo "DOCKER_OPTS=\"--host tcp://0.0.0.0:2376\"" > /etc/default/docker'
  config.vm.provision "docker"
  config.vm.provision "shell", inline: 'echo "export DOCKER_HOST=\"tcp://127.0.0.1:2376\"" >> /home/vagrant/.bashrc'
  config.vm.provision "shell", inline: "cd /vagrant && make"
end
