docker stop mha-manager
docker rm mha-manager
docker rm $(docker ps -qa --no-trunc --filter "status=exited")
docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
docker volume ls -qf dangling=true | xargs -r docker volume rm

docker run --name='mha-manager' -d --net mysql_net --privileged -it hue/mha-manager
