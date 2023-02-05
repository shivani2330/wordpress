#! /bin/bash

hdd="/dev/xvdb /dev/xvdc /dev/xvdd"
for i in $hdd;do
echo "n
p
1


w
"|fdisk $i;mkfs.ext4 "$i1";done 