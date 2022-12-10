# Sleep-On-Lan

For the Sleep-On-Lan [this github project](https://github.com/SR-G/sleep-on-lan) can be used. 

It works with the same magic package as Wake-On-Lan but uses the reversed MAC to put the server to sleep. Therefore the same tools which can send a Wake-On-Lan request can be used to shutdown the server.

For easy access the prebuild binaries are included in this repository.

Unpack the zip archive for example with `unzip` and install/ copy the binary to `/usr/local/sbin` (or any other destination you like).

This tool has also a RESTful service available which can also be used to sleep or do other actions.

In this configuration the RESTful service should not be used and a own configuration file will be used for sleep-on-lan.

The example configuration can be found in [here](./sol.json). It deactivates the RESTful service and also changes the default command to a real shutdown. The defautl of the tool is only a suspend. 

Also the service needs to be created which will automatically start and listen for sleep-on-lan.

A file under `/etc/systemd/system` needs to be created. For example `sleep-on-lan.service`:

```
[Unit]
Description=Sleep-On-LAN daemon

[Service]
User=root
WorkingDirectory=/usr/local/sbin
ExecStart=/usr/local/sbin/sol -c <path-to-repo>/tools/sleep-on-lan/sol.json
Restart=always

[Install]
WantedBy=multi-user.target
```

Change the path for the configuration file (`ExecStart`) to the configuration file to be used.

After that service can be started with:

```sh
sudo systemctl daemon-reload
sudo systemctl enable sleep-on-lan.service
sudo systemctl start sleep-on-lan.service
```

To shutdown the server send a magic package to the reversed MAC must be send. 

When the MAC is `a1:b2:c3:d4:e6:f7` use the MAC `f7:e6:d4:c3:b2:a1`.