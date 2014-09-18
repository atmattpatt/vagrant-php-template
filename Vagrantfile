VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/1/providers/virtualbox.box"

  config.vm.network :forwarded_port, guest: 8000, host: 8000

  config.ssh.forward_agent = true

  config.vm.synced_folder "./data", "/vagrant_data"
  config.vm.synced_folder "./salt", "/srv/salt"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end

  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
  end
end
