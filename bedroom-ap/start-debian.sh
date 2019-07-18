#!/bin/bash

# Needed for Mega cloud backups
export LD_LIBRARY_PATH=/usr/local/lib/

chmod -R 700 /root/.ssh
chmod 777 /run/screen

chmod u+s /usr/bin/sudo
chmod g+s /usr/bin/sudo

/usr/sbin/ntpdate-debian

chmod 700 -R /etc/ssh /var/run/sshd

/etc/init.d/rsyslog    start
/etc/init.d/ntp        start
/etc/init.d/cron       start
/etc/init.d/rpcbind    start
/etc/init.d/postfix    start
/etc/init.d/nis        start
/etc/init.d/ssh        start

#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --daemon Box:/FlossWare        /mnt/cloud/Box
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --daemon Dropbox:/FlossWare    /mnt/cloud/Dropbox
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --daemon Google:/FlossWare     /mnt/cloud/Google
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --daemon Jottacloud:/FlossWare /mnt/cloud/Jottacloud
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --daemon Mega:/FlossWare       /mnt/cloud/Mega
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --daemon Microsoft:/FlossWare  /mnt/cloud/Microsoft
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --daemon OpenDrive:/FlossWare  /mnt/cloud/OpenDrive
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --daemon Yandex:/FlossWare     /mnt/cloud/Yandex
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --daemon pCloud:/FlossWare     /mnt/cloud/pCloud

/usr/bin/sudo /root/gopath/bin/rclone mount --daemon Box:/FlossWare        /mnt/cloud/Box
/usr/bin/sudo /root/gopath/bin/rclone mount --daemon Dropbox:/FlossWare    /mnt/cloud/Dropbox
/usr/bin/sudo /root/gopath/bin/rclone mount --daemon Google:/FlossWare     /mnt/cloud/Google
/usr/bin/sudo /root/gopath/bin/rclone mount --daemon Jottacloud:/FlossWare /mnt/cloud/Jottacloud
/usr/bin/sudo /root/gopath/bin/rclone mount --daemon Mega:/FlossWare       /mnt/cloud/Mega
/usr/bin/sudo /root/gopath/bin/rclone mount --daemon Microsoft:/FlossWare  /mnt/cloud/Microsoft
/usr/bin/sudo /root/gopath/bin/rclone mount --daemon OpenDrive:/FlossWare  /mnt/cloud/OpenDrive
/usr/bin/sudo /root/gopath/bin/rclone mount --daemon Yandex:/FlossWare     /mnt/cloud/Yandex
/usr/bin/sudo /root/gopath/bin/rclone mount --daemon pCloud:/FlossWare     /mnt/cloud/pCloud

nohup /usr/local/bin/mega-cmd-server &