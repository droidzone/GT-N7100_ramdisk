#!/sbin/busybox sh

# Execute any found init.d scripts
if cd /system/etc/init.d >/dev/null 2>&1 ; then
    for file in * ; do
        if ! cat "$file" >/dev/null 2>&1 ; then continue ; fi
        chmod 755 "$file"
        /system/bin/sh "$file"
    done
fi

