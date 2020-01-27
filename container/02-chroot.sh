# Install arch to another directory.
# Most systems have their own tool to get the system files.
# TODO: Add other tools here.
sudo pacstrap system-root base base-devel

# Run jail
# This is what we call a jail, a isolated filesystem,
# meaning the running process can't have access to the host files.
sudo chroot system-root

# Check proccesses
# But, let's see if we can see the running proccesses.
ps ax -o pid,ppid,pidns,cmd --forest

# Mount /proc
# We can't see the running procceses, because they depend on /proc
# structure. Since we don't have one for our proccess, let's try
# to mount a new one.
mount -t proc none /proc

# Check proccesses again.
sudo ps ax -o pid,ppid,pidns,cmd --forest