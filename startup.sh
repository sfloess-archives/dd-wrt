#!/bin/sh

# ---------------------------------------------------------------------

ENTWARE_DIR=/mnt/sda1/entware
DEBIAN_DIR=/mnt/sda1/debian_armel

NFS_DIRS='root home opt/backups opt/media opt/nas opt/shared'

# ---------------------------------------------------------------------

mountEntwareDirs() {
    mount -o bind ${ENTWARE_DIR} /opt

    modprobe fuse

    for nfsDir in ${NFS_DIRS}
    do
	MOUNT_DIR=${DEBIAN_DIR}/mnt/admin-ap/`basename ${nfsDir}`

	mkdir -p ${MOUNT_DIR}

        /opt/bin/nfusr nfs://admin-ap/${nfsDir} ${MOUNT_DIR}
    done
}

startEntware() {
    mountEntwareDirs
}

# ---------------------------------------------------------------------

mountDebianDirs() {
    mount -o bind   /dev  ${DEBIAN_DIR}/dev
    mount -o bind   /proc ${DEBIAN_DIR}/proc
    mount -o bind   /sys  ${DEBIAN_DIR}/sys
    mount -o bind   /tmp  ${DEBIAN_DIR}/tmp

    mount -t devpts none  ${DEBIAN_DIR}/dev/pts

    mkdir -p ${DEBIAN_DIR}/mnt/`hostname`
    mount -o bind / ${DEBIAN_DIR}/mnt/`hostname`
}

copyDebianFiles() {
    cp /etc/mtab ${DEBIAN_DIR}/etc/mtab
    cp /etc/mtab ${DEBIAN_DIR}/etc/fstab

    rm -rf ${DEBIAN_DIR}/lib/modules/*                                        
    cp -rf /lib/modules/`uname -r` ${DEBIAN_DIR}/lib/modules/  
}

startDebianApps() {
    /usr/sbin/chroot ${DEBIAN_DIR} /mnt/admin-ap/root/Development/github/sfloess/dd-wrt/`hostname`/startup.sh >> /tmp/flossware.log 2>&1
}

startDebian() {
    mountDebianDirs
    copyDebianFiles

    startDebianApps
}

# --------------------------------------------------------------

startEntware
startDebian

# --------------------------------------------------------------

