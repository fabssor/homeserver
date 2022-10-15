services=(heimdall portainer samba)

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for service in "${services[@]}"
do
   cd $service
   docker compose down
   cd $SCRIPT_DIR

done