#!/bin/bash

docker rm $(docker ps -qa --no-trunc --filter "status=exited")
docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
docker volume ls -qf dangling=true | xargs -r docker volume rm
