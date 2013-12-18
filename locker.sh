lock() { # This freezes the user account if the proper directories are in place.	
if [ "$OPTARG" == "sistem" ];
then
	if [ ! -f /etc/initramfs-tools/hooks/ro_root ];
	then
		cp script/hook /etc/initramfs-tools/hooks/ro_root
		chmod +x /etc/initramfs-tools/hooks/ro_root
	fi
	if [ ! -f /etc/initramfs-tools/scripts/init-bottom/ro_root ];
	then
		cp script/init /etc/initramfs-tools/scripts/init-bottom/ro_root
		chmod +x /etc/initramfs-tools/scripts/init-bottom/ro_root
	fi	
	update-initramfs -u -k all
	rm /etc/initramfs-tools/hooks/ro_root	
	rm /etc/initramfs-tools/scripts/init-bottom/ro_root
	touch /var/ubezee/LOCKED
	exit 0
else
	if [ ! -d /var/ubezee/home/$OPTARG.dynamic ];
		then
			prep;
	fi

	if [ ! -f /etc/fstab.thaw ];
		then
			cp /etc/fstab /etc/fstab.thaw
	fi
	echo tmpfs /var/ubezee/home/$OPTARG.dynamic tmpfs defaults,noatime,uid=1000,gid=1000 0 0 >> /etc/fstab
	echo none /home/$OPTARG aufs br=/var/ubezee/home/$OPTARG.dynamic=rw:/home/$OPTARG=ro 0 0 >> /etc/fstab
fi
}
prep() { # This prepares a user account for freezing.

if [ ! -d /var/ubezee/home/$OPTARG.dynamic ];
	then
		mkdir -p /var/ubezee/home/$OPTARG.dynamic
		chown $OPTARG.$OPTARG /var/ubezee/home/$OPTARG.dynamic
fi
}

unlock() { # Unfreezes a specific user or directory
echo "$OPTARG"
if [ "$OPTARG" == "sistem" ];
then
	if [ -d /ro ];
	then
		mount -o remount,rw /ro		
		chroot /ro update-initramfs -u -k all
		if [ -f /ro/var/ubezee/LOCKED ]
		then
			rm /ro/var/ubezee/LOCKED
		fi
		mount -o remount,ro /ro
	else
		if [ -f /etc/initramfs-tools/hooks/ro_root ];
		then
			rm /etc/initramfs-tools/hooks/ro_root
			
		fi
		if [ -f /etc/initramfs-tools/scripts/init-bottom/ro_root ];
		then
			rm /etc/initramfs-tools/scripts/init-bottom/ro_root
		fi
		update-initramfs -u -k all
	fi
	if [ -f /var/ubezee/LOCKED ]
	then
			rm /var/ubezee/LOCKED
	fi
else
	SPEC=`echo "$OPTARG" | sed -e "s/\/*$//" ` # Removes the trailing slash of $OPTARG
	if [ ! -f /etc/fstab.thaw ];
		then
			echo $"There are no users or directories 'frozen'. Exiting..."
			exit 0
	fi

	if [ -d /var/ubezee/home/$SPEC.dynamic ];
		then
			sed -i '\:/home/'$SPEC': d' /etc/fstab
	fi
fi
}

while getopts h:l:u: OPT; do
    case "$OPT" in
	l)	lock;
		exit 0	
		;;
	u)	unlock;
		exit 0
		;;
    esac
done
if [ $# -le 1 ]; then
       exit 0;
fi

