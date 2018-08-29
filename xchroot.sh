#!/bin/bash

on_start() {
	echo 'Mounting dev...'
	mkdir -p ${CHROOT}/dev
	mount --bind /dev ${CHROOT}/dev
	
	echo 'Mounting dev/pts...'
	mkdir -p ${CHROOT}/dev/pts
	mount -t devpts none ${CHROOT}/dev/pts
	
	echo 'Mounting proc...'
	mkdir -p ${CHROOT}/proc
	mount --bind /proc ${CHROOT}/proc
	
	echo 'Mounting sys...'
	mkdir -p ${CHROOT}/sys
	mount --bind /sys ${CHROOT}/sys
	
	echo 'Copying resolv.conf...'
	mkdir -p ${CHROOT}/etc
	if [[ -f /etc/resolv.conf ]]; then
		cp /etc/resolv.conf ${CHROOT}/etc/resolv.conf
	fi
	
	echo 'Enabling X...'
	xhost +
}

on_exit() {
	echo 'Umounting sys...'
	umount ${CHROOT}/sys && rm -r ${CHROOT}/sys
	
	echo 'Umounting proc...'
	umount ${CHROOT}/proc && rm -r ${CHROOT}/proc
	
	echo 'Umounting dev/pts...'
	umount ${CHROOT}/dev/pts
	
	echo 'Umounting dev...'
	umount ${CHROOT}/dev && rm -r ${CHROOT}/dev
}

##################################
##########     Main     ##########
##################################

CHROOT=`readlink -f -- .`

if [[ ${UID} -ne 0 ]]; then
	echo 'ERROR: Run as root.'
	exit 1
fi

if [[ ! -f ${CHROOT}/bin/bash ]]; then
	echo 'ERROR: '${CHROOT}'/bin/bash not found.'
	exit 1
fi

if [[ ! -d ${CHROOT}/lib ]]; then
	echo 'ERROR: '${CHROOT}'/lib not found.'
	exit 1
fi

echo 'chroot directory: '${CHROOT}

on_start
chroot ${CHROOT}
on_exit

echo 'Done'
