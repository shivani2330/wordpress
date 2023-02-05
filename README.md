# wordpress


# Two Ec2 Linux instances one acting as web server and the pther acting as db server

# Create 3 volumes or as per you want , and attach the volume 

# lsblk

# https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script

# sudo gdisk /dev/xvdf  To write a single partition on the dsik

#  sudo yum install lvm2

# sudo lvmdiskscan command to check for available partitions.

# Use pvcreate utility to mark each of 3 disks as physical volumes (PVs) to be used by LVM

# sudo wipefs -a /dev/xvdb && sudo pvcreate /dev/xvdb


# sudo pvcreate /dev/xvdf1
# sudo pvcreate /dev/xvdg1
# sudo pvcreate /dev/xvdh1

# sudo pvs

# Use vgcreate utility to add all 3 PVs to a volume group (VG). Name the VG webdata-vg

# sudo vgcreate webdata-vg /dev/xvdh1 /dev/xvdg1 /dev/xvdf1

# Use lvcreate utility to create 2 logical volumes. apps-lv (Use half of the PV size), and logs-lv Use the remaining space of the PV size. NOTE: apps-lv will be used to store data for the Website while, logs-lv will be used to store data for logs.

# sudo lvcreate -n db-lv -L 20G vg-database

# sudo vgdisplay -v #view complete setup - VG, PV, and LV
# sudo lsblk

# sudo mkfs -t ext4 /dev/webdata-vg/apps-lv
# sudo mkfs -t ext4 /dev/webdata-vg/logs-lv

# sudo mkdir -p /var/www/html

# sudo mkdir -p /home/recovery/logs

# Use rsync utility to backup all the files in the log directory /var/log into /home/recovery/logs (This is required before mounting the file system)
# sudo rsync -av /var/log/. /home/recovery/logs/

# sudo mount /dev/webdata-vg/logs-lv /var/log

# We cannot create physical volume directly on the device , we need to mount it on the partition

# We cannot create the logical volume directly on the physical volume , lv needs to resides on the volume group 

# sudo mkfs -t ext4 /dev/webdata-vg/apps-lv


# /dev/webdata-vg/apps-lv is a device we need to convert it into a filesystem

# rsync  

# Mount /var/www/html on apps-lv logical device

# This means that place the apps -lv on /var/www/html directory , whatever is stored in this directory will be existing on the apps-lv device

# sudo mount -a
# If the command is errorless then there is no error in the configuration

# Thus, in 2>&1:

# 2> redirects stderr to an (unspecified) file.
# &1 redirects stderr to stdout.

# -z	Checks if the given string operand size is zero; if it is zero length, then it returns true.	[ -z $a ] is not true.
# -n	Checks if the given string operand size is non-zero; if it is nonzero length, then it returns true.	[ -n $a ] is not false.

# 
# >> /dev/null redirects standard output (stdout) to /dev/null, which discards it.

<!-- The >> seems sort of superfluous, since >> means append while > means truncate and write, and either appending to or writing to /dev/null has the same net effect. I usually just use > for that reason.)

2>&1 redirects standard error (2) to standard output (1), which then discards it as well since standard output has already been redirected. -->

# https://gist.github.com/sozercan/e089f34fd148156facea27583c12e2e0

# shell> sudo grep 'temporary password' /var/log/mysqld.log

# ALTER USER 'root'@'localhost' IDENTIFIED BY 'Sudha@3000';

# CREATE USER `wordpress`@`172.31.37.203` IDENTIFIED BY 'Sudha@3000';

# GRANT ALL ON wordpress.* TO `wordpress`@`172.31.37.203`;

# sudo mysql -u root -p -h 172.31.38.41

# sudo yum install -y php7.4-cli php7.4-dev php7.4-pgsql php7.4-sqlite3 php7.4-gd php7.4-curl php7.4-memcached php7.4-imap php7.4-mysql php7.4-mbstring php7.4-xml php7.4-imagick php7.4-zip php7.4-bcmath php7.4-soap php7.4-intl php7.4-readline php7.4-common php7.4-pspell php7.4-tidy php7.4-xmlrpc php7.4-xsl php7.4-opcache php7.4-apcu


# sudo vi /etc/my.cnf
# bind-address=0.0.0.0.0

# In the web server add 

# vi wp-config.php Add the database name 