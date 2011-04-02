virsh destroy lab
sudo lvremove -f /dev/vg0/vmlabsnap
sudo lvcreate -s -L+500M -n vmlabsnap /dev/vg0/vmlab  
