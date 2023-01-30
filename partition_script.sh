#! /bin/bash

hdd="/dev/xvdf /dev/xvdg /dev/xvdf"
for i in $hdd;do
echo "n
p
1


w
"|fdisk $i;mkfs.ext4 "$i1";done 