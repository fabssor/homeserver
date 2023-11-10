# Homeserver

A personal homeserver with different services and tools build up with docker compose.

All services run as docker container for easy extending, updating and removing functionality.

Additionaly some tools are directly installed/ configured on the server.

## Current Setup

This Homeserver is currently running on a Ubuntu Server 22.04 LTS.

## Tools

Tools need to be installed directly (without docker or similar) on the machine.

### Wake-On-Lan

For a example on how to configure wake-on-lan go to [Wake-On-Lan](tools/wake-on-lan/Readme.md).

### Sleep-On-Lan

For a example on how to configure sleep-on-lan go to [Sleep-On-Lan](tools/sleep-on-lan/Readme.md).

## Services

Once all services have been started, they will automatically start-up again when the serves is turned on.

All the persistent data of the docker services will be stored under `/srv/<service-name>`.

### Heimdall

Heimdall will be accessible through the IP and/ or servername over the browser.

You can for example also add your router Webpage here for easy access:

Links: 

- [Github](https://github.com/linuxserver/Heimdall)
- [Dockerhub](https://hub.docker.com/r/linuxserver/heimdall)

### Portainer

Portainer can be used to monitor all the services via the browser. It will be available at port 9000.

Links: 

- [Offical Website](https://www.portainer.io/)
- [Dockerhub](https://hub.docker.com/r/portainer/portainer)

Portainer has currently no full-control over the services since they are not started over the webpage of portainer!

### Samba

Samba will make some shares available.
Create a `.env` file in 

Links: 

- [Github](https://github.com/dperson/samba)
- [Dockerhub](https://hub.docker.com/r/dperson/samba)