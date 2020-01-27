# List cgroups
sudo ls /sys/fs/cgroup/

# Create CPU
sudo mkdir /sys/fs/cgroup/cpu/contains

# List files kernel has added.
sudo ls /sys/fs/cgroup/cpu/contains

# Show current limitations
sudo cat /sys/fs/cgroup/cpu/contains/cpu.cfs_period_us
sudo cat /sys/fs/cgroup/cpu/contains/cpu.cfs_quota_us

# Limit Hard CPU
sudo echo 50000 > /sys/fs/cgroup/cpu/contains/cpu.cfs_quota_us

# Create memory
sudo mkdir /sys/fs/cgroup/memory/contains

# List files kernel has added.
sudo ls /sys/fs/cgroup/memory/contains

# Limit memory
echo 100000000 > /sys/fs/cgroup/memory/contains/memory.limit_in_bytes
echo 0 > /sys/fs/cgroup/memory/contains/memory.swappiness

# Add proccess to cgroups
echo <pid> > /sys/fs/cgroup/cpu/contains/cgroup.procs
echo <pid> > /sys/fs/cgroup/memory/contains/cgroup.procs