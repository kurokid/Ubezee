#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os

HOOK_PATH = "/etc/initramfs-tools/hooks/ro_root"
INIT_PATH = "/etc/initramfs-tools/scripts/init-bottom/ro_root"
ROOT_PATH = "/root.ro/"
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
        self.proses = True
        
    def getStatus(self):
        return os.path.exists(ROOT_PATH)
            
    def getLock(self):
        if os.path.isfile(HOOK_PATH):
            if os.path.isfile(INIT_PATH):
                self.locked = True
            else:
                self.locked = False
        else:
            self.locked = False
        
        return self.locked
    
    def isLocking(self):
        return self.proses
    
    def setLocking(self, proses):
        if self.proses != proses:
            self.proses = proses
    
    def changeLock(self):
        status = True
        if not self.getLock():
            self.setLocking(True)
            try:
                f = open(HOOK_PATH, "w")
                f.write(HOOK_SCRIPT)
            except IOError:
                status = False
                return
            f.close()
            
            try:
                f = open(INIT_PATH, "w")
                f.write(INIT_SCRIPT)
                
            except IOError:
                status = False
                return
            f.close()
            if status:
                os.chmod(HOOK_PATH, 0o755)
                os.chmod(INIT_PATH, 0o755)
        else:
            self.setLocking(False)
            if self.getStatus():
                os.remove("/root.ro" + HOOK_PATH)
                os.remove("/root.ro" + INIT_PATH)
            try:
                os.remove(HOOK_PATH)
                os.remove(INIT_PATH)
            except OSError:
                status = False
        return status
