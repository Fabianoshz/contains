# List cgroups
sudo ls /sys/fs/cgroup/

# Create CPU
sudo mkdir /sys/fs/cgroup/cpu/contains

# Limit Hard CPU
sudo echo 50000 > /sys/fs/cgroup/cpu/contains/cpu.cfs_quota_us

# Create memory
sudo mkdir /sys/fs/cgroup/memory/contains

# Limit memory
echo 100000000 > /sys/fs/cgroup/memory/contains/memory.limit_in_bytes
echo 0 > /sys/fs/cgroup/memory/contains/memory.swappiness

# (As root) Add proccess to cgroups
echo $$ > /sys/fs/cgroup/cpu/contains/tasks
echo $$ > /sys/fs/cgroup/memory/contains/tasks