[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[appurl]: http://bwssystems.com/#/habridge
[dockerfileurl]: https://github.com/linuxserver/docker-habridge/blob/master/Dockerfile
[hub]: https://hub.docker.com/r/linuxserver/habridge/



[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png?v=4&s=4000)][linuxserverurl]


## Contact information:- 

| Type | Address/Details | 
| :---: | --- |
| Discord | [Discord](https://discord.gg/YWrKVTn) |
| IRC | freenode at `#linuxserver.io` more information at:- [IRC][ircurl]
| Forum | [Linuserver.io forum][forumurl] |

&nbsp;
&nbsp;

The [LinuxServer.io][linuxserverurl] team brings you another image release featuring :-

 + regular and timely application updates
 + easy user mappings
 + custom base image with s6 overlay
 + weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 + security updates

# linuxserver/habridge

[![Dockerfile-link](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/Dockerfile-Link-green.png)][dockerfileurl]

[ha-bridge][appurl] emulates Philips Hue API to other home automation gateways such as an Amazon Echo/Dot Gen 1 (gen 2 has issues discovering ha-bridge) or other systems that support Philips Hue. The Bridge handles basic commands such as "On", "Off" and "brightness" commands of the hue protocol. This bridge can control most devices that have a distinct API.

In the cases of systems that require authorization and/or have APIs that cannot be handled in the current method, a module may need to be built. The Harmony Hub is such a module and so is the Nest module. The Bridge has helpers to build devices for the gateway for the Logitech Harmony Hub, Vera, Vera Lite or Vera Edge, Nest, Somfy Tahoma, Home Assistant, Domoticz, MQTT, HAL, Fibaro, HomeWizard, LIFX, OpenHAB, FHEM, Broadlink and the ability to proxy all of your real Hue bridges behind this bridge.

This bridge was built to help put the Internet of Things together.

For more information about how to use this software have a look at their Wiki [https://github.com/bwssytems/ha-bridge/wiki](https://github.com/bwssytems/ha-bridge/wiki)

[![ha-bridge](https://raw.githubusercontent.com/bwssytems/ha-bridge/master/src/main/resources/public/img/favicon.ico)][appurl]
&nbsp;

## Usage

```
docker create \
  --name=habridge \
  --net=bridge \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -e SEC_KEY=<Your Key To Encrypt Security Data>
  -p 8080:8080 \
  -p 50000:50000 \
  linuxserver/habridge
```

&nbsp;

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.



| Parameter | Function |
| :---: | --- |
| `-p 1234` | the port(s) |
| `-v /config` | explain what lives here |
| `-e PGID` | for GroupID, see below for explanation |
| `-e PUID` | for UserID, see below for explanation |

&nbsp;

## User / Group Identifiers

Sometimes when using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and it will "just work" &trade;.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

&nbsp;

## Setting up the application

To set up the ha-bridge simply go to http://<IP of your docker host>:<port you mapped to 8080>. Once you are in the webui you can add devices and configure ha-bridge to your liking.

For information on how to configure ha-bridge, go to their wiki at [https://github.com/bwssytems/ha-bridge/wiki](https://github.com/bwssytems/ha-bridge/wiki)


&nbsp;

## Container access and information.

| Function | Command |
| :--- | :--- |
| Shell access (live container) | `docker exec -it <container-name> /bin/bash` |
| Realtime container logs | `docker logs -f <container-name>` |
| Container version | `docker inspect -f '{{ index .Config.Labels "build_version" }}' <container-name>` |
| Image version |  `docker inspect -f '{{ index .Config.Labels "build_version" }}' <image-name>` |
| Dockerfile | [Dockerfile][dockerfileurl] |

&nbsp;

## Changelog

|  Date | Changes |
| :---: | --- |
| 12.04.18 |  Add workaround tobind to port 80 if needed. |
| 08.04.18 |  Initial Release. |
