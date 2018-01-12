docker exec -it mysql-master /bin/bash service ssh start
docker exec -it mysql-slave1 /bin/bash service ssh start
docker exec -it mysql-slave2 /bin/bash service ssh start
docker exec -it mha-manager /bin/bash service ssh start
