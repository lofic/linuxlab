# This is how I mount automatically an external 'USB' disk with the iso images
# and repos
#
# In /etc/udev/rules.d/99-custom.rules :
# SUBSYSTEM=="block", ENV{ID_MODEL}=="My_Passport_0730", SYMLINK+="usbdisk%n"
# ACTION=="add", SUBSYSTEM=="block", ENV{ID_MODEL}=="My_Passport_0730", RUN+="/bin/mount /mnt/usbdisk"
#
# Of course there is an entry in /etc/fstab for /dev/usbdisk1 :
# /dev/usbdisk1 /mnt/usbdisk ext4 defaults,rw,nosuid,nodev,users,noauto 0 0
#
# I get the ID_MODEL of my 'USB' disk with :
# udevadm control --log-priority=debug 
# udevadm test /block/sdb 2>&1 | grep ID_MODEL


# provide the kickstarts, repos
sudo service apache2 restart

# provide the DHCP service if needed
#sudo service dhcp3-server start
