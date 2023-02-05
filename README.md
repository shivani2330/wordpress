# wordpress

![image](https://user-images.githubusercontent.com/34639977/216816665-91687c81-c6ab-4d8e-9a1a-77b3744ae838.png)



# Two Ec2 Linux instances one acting as web server and the pther acting as db server

# Create 3 volumes or as per you want , and attach the volume 

# lsblk

# https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script

# sudo gdisk /dev/xvdf  To write a single partition on the dsik

#  sudo yum install lvm2

# sudo lvmdiskscan command to check for available partitions.

# Use pvcreate utility to mark each of 3 disks as physical volumes (PVs) to be used by LVM

# sudo pvcreate /dev/xvdf1
# sudo pvcreate /dev/xvdg1
# sudo pvcreate /dev/xvdh1

# sudo pvs

# Use vgcreate utility to add all 3 PVs to a volume group (VG). Name the VG webdata-vg

# sudo vgcreate webdata-vg /dev/xvdh1 /dev/xvdg1 /dev/xvdf1

# Use lvcreate utility to create 2 logical volumes. apps-lv (Use half of the PV size), and logs-lv Use the remaining space of the PV size. NOTE: apps-lv will be used to store data for the Website while, logs-lv will be used to store data for logs.

# sudo vgdisplay -v #view complete setup - VG, PV, and LV
# sudo lsblk

# sudo mkfs -t ext4 /dev/webdata-vg/apps-lv
# sudo mkfs -t ext4 /dev/webdata-vg/logs-lv

# sudo mkdir -p /var/www/html

# sudo mkdir -p /home/recovery/logs

# Use rsync utility to backup all the files in the log directory /var/log into /home/recovery/logs (This is required before mounting the file system)
# sudo rsync -av /var/log/. /home/recovery/logs/

# sudo mount /dev/webdata-vg/logs-lv /var/log
