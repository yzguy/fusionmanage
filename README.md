FusionManage
============

FusionManage is a command-line utility to manage VMware Fusion's networking. Unfortunately, there is not an easy way to manage it from the GUI, however this utility should do the trick.

Features:
* Stop, Start, Restart Networking
* TCP/UDP Port Forwarding

[![Code Climate](https://codeclimate.com/github/yzguy/fusionmanage/badges/gpa.svg)](https://codeclimate.com/github/yzguy/fusionmanage)

### Getting Started
TODO

### Commands
\* **Must be run with sudo** \*

#### Start Networking
```
user@host:~# sudo fusionmanage start-network
Enabled hostonly virtual adapter on vmnet1
Started DHCP service on vmnet1
Started NAT service on vmnet8
Enabled hostonly virtual adapter on vmnet8
Started DHCP service on vmnet8
Started all configured services on all networks
```

#### Stop Networking
```
user@host:~# sudo fusionmanage stop-network
Stopped DHCP service on vmnet1
Disabled hostonly virtual adapter on vmnet1
Stopped DHCP service on vmnet8
Stopped NAT service on vmnet8
Disabled hostonly virtual adapter on vmnet8
Stopped all configured services on all networks
```

#### Restart Networking
```
user@host:~# sudo fusionmanage restart-network
Stopped DHCP service on vmnet1
Disabled hostonly virtual adapter on vmnet1
Stopped DHCP service on vmnet8
Stopped NAT service on vmnet8
Disabled hostonly virtual adapter on vmnet8
Stopped all configured services on all networks
Enabled hostonly virtual adapter on vmnet1
Started DHCP service on vmnet1
Started NAT service on vmnet8
Enabled hostonly virtual adapter on vmnet8
Started DHCP service on vmnet8
Started all configured services on all networks
```

### Port Forwarding

One of the best features is the ability to manage port forwarding from your host to one of your running VMs

#### Show Forwards
```
user@host:~# sudo fusionmanage show-forwards
TCP Port Forwards
=================
8080 => 192.168.0.10:8080

UDP Port Forwards
=================
```

#### Add TCP/UDP Forward

TCP:
```
user@host:~# sudo fusionmanage add-tcp-forward 192.168.0.10 8080
ADDED: 8080 => 192.168.0.10:8080

Restart VMware Fusion Networking to take effect
```

UDP:
```
user@host:~# sudo fusionmanage add-udp-forward 192.168.0.10 53
ADDED: 53 => 192.168.0.10:53

Restart VMware Fusion Networking to take effect
```

#### Delete TCP/UDP Forward

TCP:
```
user@host:~# sudo fusionmanage delete-tcp-forward 8080
DELETED: 8080 => 8080

Restart VMware Fusion Networking to take effect
```

UDP:
```
user@host:~# sudo fusionmanage delete-udp-forward 53
DELETED: 53 => 53

Restart VMware Fusion Networking to take effect
```
