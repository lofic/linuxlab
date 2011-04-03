install
lang fr_FR.UTF-8
keyboard fr-latin9
skipx
text

network --device=eth0 --bootproto=dhcp --hostname=lab

rootpw  --iscrypted $6$jEeq2Jyj$tZprcQ6YAJoxZjfLKVDunoyxvg9TzuZyJwhcRDrGVC60BaspheAR9FRgVbVCDGnF1a5kwaCRBiYfNG0SL1U64/ 
firewall --service=ssh
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
selinux --enforcing
timezone --utc Europe/Paris
bootloader --location=mbr --driveorder=sda --append="crashkernel=auto rhgb quiet"

reboot

zerombr
clearpart --all
#autopart
part /boot --fstype ext4 --size=100
part swap --size=100
#part pv.01 --size=1 --grow
part pv.01 --size=2050
volgroup vg_root pv.01
#logvol / --vgname=vg_root --size=1 --grow --name=lv_root
logvol / --vgname=vg_root --size=2000  --name=lv_root



%packages --nobase
@core
#@ X Window System 
#@ Desktop 
#@ Internet Browser
#@ legacy-x
#@ fonts
openssh-clients
%end

# Taches de post installation
%post
#--nochroot 

/sbin/chkconfig smartd off
echo "RUN_FIRSTBOOT=NO" > /etc/sysconfig/firstboot
cp -p /boot/grub/grub.conf /boot/grub/grub.conf.DIST

initfile=/etc/inittab

cp -f $xconf $xconf.ori 
cp -f $initfile $initfile.ori 

sed -i 's/^id:5:/id:3:/g' $initfile

/usr/sbin/adduser bob
/usr/sbin/usermod -p CXl5ww5.VOOy6 bob

ed /boot/grub/grub.conf <<EOF
g!hiddenmenu!s!!#hiddenmenu!gp
g! rhgb quiet!s!!!gp
g! quiet!s!!!g
wq
EOF

sed -i '/GSSAPIAuthentication/d' /etc/ssh/sshd_config
echo 'GSSAPIAuthentication no' >> /etc/ssh/sshd_config
sed -i '/UseDNS/d' /etc/ssh/sshd_config
echo 'UseDNS no' >> /etc/ssh/sshd_config

rpm -Uvh http://download.fedora.redhat.com/pub/epel/6/x86_64/epel-release-6-5.noarch.rpm

%end
