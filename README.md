FusionManage
============

FusionManage is a command-line utility to manage VMware Fusion's networking. Unfortunately, there is not an easy way to manage it from the GUI, however this utility should do the trick.

Features:
* Stop, Start, Restart Networking
* TCP/UDP Port Forwarding

[![Code Climate](https://codeclimate.com/github/yzguy/fusionmanage/badges/gpa.svg)](https://codeclimate.com/github/yzguy/fusionmanage)

### Getting Started

Install Gem

`gem install fusionmanage`

### Commands

**Note:** Must be run with sudo

```
Command-line utility to manage VMware Fusion Networking and Port Forwarding

Usage:
  fusionmanage [-a|--action] [-A|-D] [-p|--protocol] [-i|--ip] [-o|--port]

where [options] are:
-a, --action=<s>      Action to run
-A, --add             Add port forward
-D, --delete          Delete port forward
-p, --protocol=<s>    Protocol to forward
-i, --ip=<s>          IPv4 Address to forward to
-o, --port=<i>        Port to forward

[action] must be one of the following:
  start     Start VMware Fusion Networking
  stop      Stop VMware Fusion Networking
  restart   Restart VMware Fusion Networking
  show      Show All Current Port Forwards

  **If action is 'forward' you must specify one of the following:
    -A    Add Port Forward
    -D    Delete Port Forward

** Forward Only **
[protocol] must be one of the following:
  tcp   TCP Protocol
  udp   UDP Protocol

[ip] must be a valid IPv4 address (eg. 192.168.0.10)
[port] must be a valid port number (1 - 65535)
-h, --help            Show this message
```

#### Examples

Forward traffic on host TCP/8080 to VM 192.168.0.10:8080

```
sudo fusionmanage --action forward -A --protocol tcp --ip 192.168.0.10 --port 8080
```


Show current port forwards

```
user@host:~# sudo fusionmanage --action show
TCP Forwards
8080 => 192.168.0.10:8080

UDP Forwards
```
