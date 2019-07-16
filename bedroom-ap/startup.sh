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

/usr/bin/rclone mount --allow-other --daemon Box:        /mnt/cloud/Box
/usr/bin/rclone mount --allow-other --daemon Dropbox:    /mnt/cloud/Dropbox
/usr/bin/rclone mount --allow-other --daemon Google:     /mnt/cloud/Google
/usr/bin/rclone mount --allow-other --daemon Jottacloud: /mnt/cloud/Jottacloud
/usr/bin/rclone mount --allow-other --daemon Microsoft:  /mnt/cloud/Microsoft
/usr/bin/rclone mount --allow-other --daemon Yandex:     /mnt/cloud/Yandex
/usr/bin/rclone mount --allow-other --daemon pCloud:     /mnt/cloud/pCloud

nohup /usr/local/bin/mega-cmd-server &
