#!/bin/bash

pvcreate /dev/sdb

# you need run the command "vgdisplay" on the box to detemine which "VolGroup" and "VolGroup-lv_root" to be used.
vgextend VolGroup /dev/sdb
lvextend -l 100%FREE --resizefs /dev/mapper/VolGroup-lv_root
