#!/bin/bash
docker stop mysql-master 
docker rm mysql-master 

docker rm $(docker ps -qa --no-trunc --filter "status=exited")
docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
docker volume ls -qf dangling=true | xargs -r docker volume rm
docker run --name='mysql-master' -d --net mysql_net --cap-add=NET_ADMIN --cap-add=NET_RAW -e 'MYSQL_MODE=master' -e 'DB_NAME=smartschooldb' -e 'MYSQL_USER=smartschooluser' -e 'MYSQL_PASS=smartschoolpass' smartschool/mysql-mha-x

