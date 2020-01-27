# Namespaced system
sudo unshare -p -f --mount-proc=$PWD/system-root/proc chroot system-root /bin/bash