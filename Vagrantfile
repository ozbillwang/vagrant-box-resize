VAGRANTFILE_API_VERSION = "2"
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "fillup/centos-6.5-x86_64-minimal"
  config.vm.hostname = "web01.example.com"
  

  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "512"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]

    file_to_disk = File.join(File.dirname(__FILE__), 'resize.vdi')
    unless File.exists? file_to_disk
     # "10" means 10GB, if you need 30GB on root, just replace it to 30. 
     # Don't give too big number, otherwise it takes a while to resize. 
     vb.customize ['createhd', '--filename', file_to_disk, '--size', 10 * 1024]
    end
    # storagectl will be IDE, SATA, IDE Controller, or SATA Controller, depand on 
    vb.customize ['storageattach', :id, '--storagectl', 'SATA', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
  end

  config.vm.provision :shell, :path => 'resize.sh'
end
