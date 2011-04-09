#!/bin/bash
# This is a contribution from Luc Henninot 

SNAPIZE="500M"
XML="/etc/libvirt/qemu"

# Get domain list
DOMAINS=$(LANG=C virsh list --all | awk '/running/ ||  /off/ {print $2}')
if [ -z "$DOMAINS" ]; then
	echo "No domain found !"
	exit
fi

# domain selection
x=1
echo "Available revert labs :"
for i in `echo $DOMAINS`; do
	echo "$x) $i"
	x=$((x+1))
done
# echo -n "Revert lab N° : "
read did

DOM=""
if [ -n "$did" ]; then
	DOM=`echo "$DOMAINS" | head -$did | tail -1`
fi

if [ -z "$DOM" ]; then
	echo "Invalid domain id $did"
	exit
else
	echo "Reverting domain $DOM ..."
fi

# Get current snap name for this domain
LVMSNAPPATH=`sudo grep "source dev" $XML/$DOM.xml | cut -d "'" -f 2`
if [ -z "$LVMSNAPPATH" ]; then
	echo "Could not get snapshot path."
	exit
else
	LVMSNAP=`basename $LVMSNAPPATH`
fi
#echo "Conf file : $XML/$DOM.xml"
#echo "Snap path : $LVMSNAPPATH"
#echo "Snap name : $LVMSNAP"

# Get orig volume for this snap
LVMORIG=`sudo lvs | grep -w $LVMSNAP | awk '{print $5}'`
if [ -z "$LVMORIG" ]; then
	echo "Unable to get original volume for snap $LVMSNAP"
	exit
#else
#	echo "Original volume : $LVMORIG"
fi

sudo virsh destroy $DOM 1>/dev/null 2>&1
sudo lvremove -f $LVMSNAPPATH
sudo lvcreate -s -L+$SNAPIZE -n $LVMSNAP `dirname $LVMSNAPPATH`/$LVMORIG
