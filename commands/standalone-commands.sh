# Host: Boostrap Arch Linux SO.
mkdir system-root && sudo pacstrap system-root base base-devel

# Host: Forked jail with namespaces.
sudo unshare --mount --uts --ipc --net --pid --cgroup --fork chroot system-root bin/bash

# Container: Mount /proc structure.
mount -t proc none /proc

# Host: Add virtual interface.
sudo ip link add name host type veth peer name container
# Host: move container tip to container NS.
sudo ip link set container netns <Container PID>
# Host: Set host interface up and add an IP address.
sudo ip link set host up
sudo ip add add 10.1.0.1/24 dev host

# Container: Set container interface up add IP address and default route.
ip link set container up
ip add add 10.1.0.2/24 dev container
ip route add default via 10.1.0.1

# Container: Add DNS server.
echo 'nameserver 8.8.8.8' > /etc/resolv.conf

# Host: Enable routing
sudo sysctl net.ipv4.conf.all.forwarding=1 # By default linux hosts don't forward IPv4 and IPv6 packets.
sudo iptables -t nat -A POSTROUTING -s 10.1.0.0/24 -o <host-interface> -j MASQUERADE
sudo iptables -A FORWARD -o <host-interface> -i host -j ACCEPT # Accept what comes from host interface to the virtual interface.
sudo iptables -A FORWARD -i <host-interface> -o host -j ACCEPT # Accept what comes from virtual interface to the host interface.

# Container: Mount root FS
mount --bind / /

# Container: Install and run nginx
sed -i 's/SigLevel    = Required DatabaseOptional/SigLevel    = Never/' /etc/pacman.conf # Disable Pacman signature validation.
pacman -S --noconfirm nginx
nginx

# Host: curl container nginx
curl 10.1.0.2