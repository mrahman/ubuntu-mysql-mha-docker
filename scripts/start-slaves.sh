#!/bin/bash
docker stop mysql-slave1 mysql-slave2
docker rm mysql-slave1 mysql-slave2

docker rm $(docker ps -qa --no-trunc --filter "status=exited")
docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
docker volume ls -qf dangling=true | xargs -r docker volume rm

docker run --name='mysql-slave1' -d --net mysql_net --cap-add=NET_ADMIN --cap-add=NET_RAW -e 'MYSQL_MODE=slave' -e 'MYSQL_PASS=smartschoolpass' -e 'REPLICATION_HOST=mysql-master' -e 'DB_REMOTE_USER=smartschooluser' -e 'DB_REMOTE_PASS=smartschoolpass' smartschool/mysql-mha-x

docker run --name='mysql-slave2' -d --net mysql_net --cap-add=NET_ADMIN --cap-add=NET_RAW -e 'MYSQL_MODE=slave' -e 'MYSQL_PASS=smartschoolpass' -e 'REPLICATION_HOST=mysql-master' -e 'DB_REMOTE_USER=smartschooluser' -e 'DB_REMOTE_PASS=smartschoolpass' smartschool/mysql-mha-x
