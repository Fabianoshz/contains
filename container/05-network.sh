# Add nameserver
echo 'nameserver 8.8.8.8' > /etc/resolv.conf

# Create virtual interfaces
sudo ip link add name host type veth peer name container

# Move one end to container network namespace
sudo ip link set container netns <pid>

# Host
sudo ip link set host up
sudo ip add add 10.1.0.1/24 dev host

# Container
ip link set container up
ip add add 10.1.0.2/24 dev container
ip route add default via 10.1.0.2

# Host routes
iptables -t nat -A POSTROUTING -s 10.1.0.2/24 -o enp2s0 -j MASQUERADE
iptables -A FORWARD -o enp2s0 -i host -j ACCEPT
iptables -A FORWARD -i enp2s0 -o host -j ACCEPT