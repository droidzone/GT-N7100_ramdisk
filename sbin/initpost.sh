#!/sbin/busybox sh

# Begin auto-root
# First - the SU binary
if [ -f /system/xbin/su ];
then
	break
else
	/sbin/busybox mount /system -o remount,rw
	/sbin/busybox rm /system/xbin/su
	/sbin/busybox cp /res/misc/su /system/xbin/su
	/sbin/busybox chown 0.0 /system/xbin/su
	/sbin/busybox chmod 6755 /system/xbin/su
	/sbin/busybox mount /system -o remount,ro
fi

# And now the Superuser application
if [ -f /system/app/Superuser.apk ];
then
	break
else
	/sbin/busybox mount /system -o remount,rw
	/sbin/busybox rm /system/app/Superuser.apk
	/sbin/busybox rm /data/app/Superuser.apk
	/sbin/busybox cp /res/misc/Superuser.apk /system/app/Superuser.apk
	/sbin/busybox chown 0.0 /system/app/Superuser.apk
	/sbin/busybox chmod 644 /system/app/Superuser.apk
	/sbin/busybox mount /system -o remount,ro
fi
# End of auto-root section

# Execute any found init.d scripts
if cd /system/etc/init.d >/dev/null 2>&1 ; then
    for file in * ; do
        if ! cat "$file" >/dev/null 2>&1 ; then continue ; fi
        /system/bin/sh "$file"
    done
fi

if cd /data/init.d >/dev/null 2>&1 ; then
    for file in * ; do
        if ! cat "$file" >/dev/null 2>&1 ; then continue ; fi
        /system/bin/sh "$file"
    done
fi



