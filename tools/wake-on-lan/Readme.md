# Wake-On-Lan

The following describes how to configure the server to wake on a magic package over lan.

At first `ethtool` needs to be installed:

```sh
sudo apt-get install ethtool
```

Afterwards identify ethernet adapter which you want to configure to use Wake-On-Lan:

```sh
ip link # show network adapters
ip address show # show network adapters and assigned ip adresses
```

The second command from above will show also the ip address. With this it might be easier to 
identify the network adapte to configure. 

In the following `eth0` is used as placeholder. replace the name with the before identified name
of the network adapter!

With 

```sh
sudo ethtool eth0
```

the current configuration of the network adapter can be inspected. The line 

```sh
Wake-on: d
```

shows the current configuration of the wake-on-lan configuration. `d` means disabled.

Full list of options can be seen with:

```sh
man ethtool
```

Somewhere in the manual this list can be found:

```sh
p   Wake on PHY activity
u   Wake on unicast messages
m   Wake on multicast messages
b   Wake on broadcast messages
a   Wake on ARP
g   Wake on MagicPacket™
s   Enable SecureOn™ password for MagicPacket™
f   Wake on filter(s)
d   Disable  (wake  on  nothing).  This option
    clears all previous options.
```

To enable Wake-On-Lan with magic package the `g` option must be enabled.

This can be done with:

```sh
sudo ethtool -s eth0 wol g
```

This configuration is not persistent! To make it persitent a file in `/etc/systemd/network` needs to be created. For example `/etc/systemd/network/10-wired.link`:

```sh
[Match]
MACAddress=XX:XX:XX:XX:XX:XX

[Link]
NamePolicy=kernel database onboard slot path
MACAddressPolicy=persistent
WakeOnLan=magic
```

