#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os

#HOOK_PATH = "/etc/initramfs­tools/hooks/ro_root"
#INIT_PATH = "/etc/initramfs­tools/scripts/init­bottom/ro_root"
HOOK_PATH = "var/hook"
INIT_PATH = "var/init"
HOOK_SCRIPT = """#!/bin/sh

PREREQ=''

prereqs() {
  echo "$PREREQ"
}

case $1 in
prereqs)
  prereqs
  exit 0
  ;;
esac

. /usr/share/initramfs-tools/hook-functions
manual_add_modules aufs
manual_add_modules tmpfs
copy_exec /bin/chmod /bin"""

INIT_SCRIPT = """#!/bin/sh

PREREQ=''

prereqs() {
  echo "$PREREQ"
}

case $1 in
prereqs)
  prereqs
  exit 0
  ;;
esac

# Boot normally when the user selects single user mode.
if grep single /proc/cmdline >/dev/null; then
  exit 0
fi

ro_mount_point="${rootmnt%/}.ro"
rw_mount_point="${rootmnt%/}.rw"
mkdir "${ro_mount_point}" "${rw_mount_point}"
mount --move "${rootmnt}" "${ro_mount_point}"
mount -t tmpfs root.rw "${rw_mount_point}"
mount -t aufs -o "dirs=${rw_mount_point}=rw:${ro_mount_point}=ro" root.union "${rootmnt}"
chmod 755 "${rootmnt}"
mkdir "${rootmnt}/ro" "${rootmnt}/rw"
mount --move "${ro_mount_point}" "${rootmnt}/ro"
mount --move "${rw_mount_point}" "${rootmnt}/rw"
rm -f "${rootmnt}/etc/rcS.d"/S[0-9][0-9]checkroot.sh"""

class Locker(object):

    def __init__(self):
        self.locked = False
        
    def getLock(self):
        if os.path.isfile(HOOK_PATH):
            if os.path.isfile(INIT_PATH):
                self.locked = True
            else:
                self.locked = False
        else:
            self.locked = False
        
        return self.locked
    
    def changeLock(self):
        status = True
        if not self.getLock():
            try:
                f = open(HOOK_PATH, "w")
                f.write(HOOK_SCRIPT)
                f.close()
            except IOError:
                status = False
                return
            
            try:
                f = open(INIT_PATH, "w")
                f.write(INIT_SCRIPT)
                f.close()
            except IOError:
                status = False
                return
            
            if status:
                os.chmod("var/hook", 0o755)
                os.chmod("var/init", 0o755)
        else:
            try:
                os.remove(HOOK_PATH)
                os.remove(INIT_PATH)
            except OSError:
                status = False
        return status