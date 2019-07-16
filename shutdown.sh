#!/bin/sh

# ---------------------------------------------------------------------

ENTWARE_DIR=/mnt/sda1/entware
DEBIAN_DIR=/mnt/sda1/debian_armel

NFS_DIRS='root home opt/backups opt/media opt/nas opt/shared'

# ---------------------------------------------------------------------

unmountEntwareDirs() {
    for nfsDir in ${NFS_DIRS}
    do
	MOUNT_DIR=${DEBIAN_DIR}/mnt/admin-ap/`basename ${nfsDir}`

        fusermount -u ${MOUNT_DIR}
    done
}

stopEntware() {
    unmountEntwareDirs

    /opt/etc/init.d/rc.unslung stop

    umount /opt
}

# ---------------------------------------------------------------------

unmountDebianDirs() {
    umount ${DEBIAN_DIR}/mnt/`hostname`
    umount ${DEBIAN_DIR}/dev/pts
    umount ${DEBIAN_DIR}/tmp

    umount ${DEBIAN_DIR}/sys
    umount ${DEBIAN_DIR}/proc
    umount ${DEBIAN_DIR}/dev
}

shutdownDebianApps() {
    /usr/sbin/chroot ${DEBIAN_DIR} /mnt/admin-ap/root/Development/github/sfloess/dd-wrt/`hostname`/shutdown.sh >> /tmp/flossware.log 2>&1
}

stopDebian() {
    shutdownDebianApps

    unmountDebianDirs
}

# --------------------------------------------------------------

stopDebian
stopEntware

# --------------------------------------------------------------

