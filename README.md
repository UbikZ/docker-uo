# Ultima Online Server (with Docker)

Ultima Online Server :
- **Built** with [Mono](http://www.mono-project.com/)
- **From** [RunUO](https://github.com/runuo/runuo) source code
- **Containerize** with [Docker](https://www.docker.com/)

## Motivation

When you talk about UO, it's all about nostalgia.
Thank's to the great work of [RunUO](https://github.com/runuo/runuo), we can host a server to play again.
**But** we have to make some installation, build, changes from source code, changes command stuff, deployment, etc.
Thus I've made docker images to handle all of this in order to allow you to deploy easily a **public** server.

## Requirements

Install **Docker** (you can test it on your own OS or directly on your server)

> [Docker](https://www.docker.com/) : Docker is the world’s leading software containerization platform.

Download game softwares

> - [UO 2D Classic Client](http://web.cdn.eamythic.com/us/uo/installers/20120309/UOClassicSetup_7_0_24_0.exe) : Official UO client, up to date. You will need to install / patch around 1,2gb files.
> - [UOSteam](http://uos-update.github.io/UOS_Latest.exe) : UOAssist / Razor client-like, but maintained. It'll be useful to disable client-encryption and to connect to a free-shard (server).

## Volumes

**Docker** allows you to keep some files like logs, backups etc. within the hosting server in order to get a container totally clean.

The volumes defined (*volume within host machine -> volume within docker container*) are :
- **Nginx**
  * ```/srv/docker/nginx/log -> /var/log/nginx``` : for Nginx logs (access && error)
- **UO Server**
  * ```/srv/docker/uo/datafiles -> /srv/docker/uo/datafiles``` : for system file game
  * ```/srv/docker/uo/save -> /runuo-master/Saves``` : for database files (XML)
  * ```/srv/docker/uo/backups -> /runuo-master/Backups``` : for backups

## Installation

1. Download the **docker-uo** package ```https://github.com/UbikZ/docker-uo/archive/master.zip```
2. Unzip it and go inside the folder
3. Copy configuration files without the ```.dist``` sufix : ```./uo/.env.conf.dist``` and ```./nginx/.env.conf.dist```
4. For ```./uo/.env.conf.dist```
  * ```UO_ADMIN_USERNAME``` (*admin*) : admin username created at the first run
  * ```UO_ADMIN_PASSWORD```(*admin*) : admin password created at the first run
  * ```UO_SERVER_NAME``` (*Uo Test Server*) : name of the shard
  * ```UO_SERVER_IP``` (*uo.localhost*) : server IP to connect to the specific shard
5. For ```./nginx/.env.conf.dist```
  * ```NGINX_DOMAIN``` (*localhost*) : the domain name for nginx
6. Copy some game files in the ```/srv/docker/uo/datafiles``` host machine volumes
  * Check the Official Ultima Online folder
  * Copy these files (*~ 650mb*):
    > map0LegacyMUL.uop multi.mul staidx0x.mul statics1.mul map0xLegacyMUL.uop stadif0.mul staidx1.mul statics1x.mul map1LegacyMUL.uop stadif1.mul staidx1x.mul statics2.mul map1xLegacyMUL.uop stadif2.mul staidx2.mul statics2x.mul map2LegacyMUL.uop stadifi0.mul staidx2x.mul statics3.mul map2xLegacyMUL.uop stadifi1.mul staidx3.mul statics4.mul map3LegacyMUL.uop stadifi2.mul staidx4.mul statics5.mul map4LegacyMUL.uop stadifl0.mul staidx5.mul statics5x.mul map5LegacyMUL.uop stadifl1.mul staidx5x.mul tiledata.mul map5xLegacyMUL.uop stadifl2.mul statics0.mul multi.idx staidx0.mul statics0x.mul

7. Execute the ```docker-compose up -d```command
8. Check the docker process are running with ```docker ps```
9. Execute the ```UOS.exe``` client and fill the fields
  * ```Client Options``` : the ```client.exe``` path from the Official UO client
  * Check ```Remove encryption```
  * ```Ultima Online Classic``` : path to the main folder of the Official UO client
  * ```Shard``` : URL / PORT of the server (uo.localhost / 2593 by default)
10. Click on **START**
11. Enjoy !

## Technical questions ?

Why do we have to use Nginx ?

> [Nginx](https://www.nginx.com/) will allow us to forward UO server port (2593) on another server name thank's to **proxypass**.

## License

This program is distributed under the terms of the MIT license. See [LICENSE](https://github.com/UbikZ/docker-uo/blob/master/LICENSE) file.
