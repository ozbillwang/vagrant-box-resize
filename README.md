# vagrant-box-resize
The repository to fixing the vagrant box (linux) root size issue

# how to use.

Due to different linux system, you need first manually find out three parameters. Use `fillup/centos-6.5-x86_64-minimal` as sample, its root filesystem is 3GB.

1) start the vagrant box with init setting. 

    vagrant up fillup/centos-6.5-x86_64-minimal --provider=virtualbox

2) find vm id

    vboxmanage list vms |awk -F \" 'END{print $2}' 

You will get some output as below, and in this case, it will be SATA. Then update it in Vagrantfile

```
$ vboxmanage showvminfo vagrant-box-resize_default_1426739272237_35766|grep Storage
Storage Controller Name (0):            IDE
Storage Controller Type (0):            PIIX4
Storage Controller Instance Number (0): 0
Storage Controller Max Port Count (0):  2
Storage Controller Port Count (0):      2
Storage Controller Bootable (0):        on
Storage Controller Name (1):            SATA
Storage Controller Type (1):            IntelAhci
VAGRANTFILE_API_VERSION = "2"
Storage Controller Instance Number (1): 0
Storage Controller Max Port Count (1):  30
Storage Controller Port Count (1):      1
Storage Controller Bootable (1):        on
```

3) login the box

    vagrant ssh

4) find "VG name"

    vgdisplay

If there is no output, run `vgscan` or `pvscan`, then run `vgdisplay` again.

5) find mapper name

    cd /dev/mapper
    ls -l 

you can get the name as "VolGroup-lv_root"  

6) replace the finding in resize.sh file.

7) destroy the box

    vagrant destroy

8) Now you can start the vagrant box properly with your expect size on root.

    vagrant up
