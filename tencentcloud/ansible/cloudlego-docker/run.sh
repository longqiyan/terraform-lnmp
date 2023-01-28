#!/usr/bin/env bash
set -x
# exec &> /tmp/debug.log

cd "$(dirname $0)"
source ./.env

HOST_IP=$(ip r get 8.8.8.8 | awk '/src/ { print $NF }')
[[ -d "$LOG_DIR" ]] || mkdir -p "$LOG_DIR"

sed --follow-symlinks -i \
    -e "s/#{INGRESS_HOST}/$INGRESS_HOST/g" \
    ./.env \
    ./sql/init.sh

sed --follow-symlinks -i \
    -e "s/#{MYSQL_DB}/$MYSQL_DB/g" \
    -e "s/#{HOST_IP}/$HOST_IP/g" \
    -e "s/#{MYSQL_USER}/$MYSQL_USER/g" \
    -e "s/#{MYSQL_PASSWORD}/$MYSQL_PASSWORD/g" \
    -e "s/#{ZOOKEEPER_HOST}/$HOST_IP:2181/g" \
    -e "s/#{ZOOKEEPER_USER}/$ZOOKEEPER_USER/g" \
    -e "s/#{ZOOKEEPER_PASSWORD}/$ZOOKEEPER_PASSWORD/g" \
    -e "s/#{KAFKA_HOST}/$HOST_IP:9092/g" \
    -e "s/#{KAFKA_USER}/$KAFKA_USER/g" \
    -e "s/#{KAFKA_PASSWORD}/$KAFKA_PASSWORD/g" \
    ./.env \
    ./sql/init.sh

if [ ! -z $REINITIALIZED_SQL ] && [ "$REINITIALIZED_SQL" == "true" ];then
    find /var/lib/docker/volumes/ -type f -name ".user_scripts_initialized" | xargs rm -f 
fi

if [ "$MYSQL_DB"  == "cloud_glide" ] || [ "$ENABLE_BACKUP"  == "true" ];then
    ## database
    docker-compose -f database.yml up -d
    while :; do
      result=$(docker inspect mysql | grep healthy)
      if [ "$result" != "" ]; then
        break
      else
        sleep 1s
      fi
    done
fi

sleep 5m

# # middleware
docker-compose -f middleware.yml up -d
while :; do
    docker exec -t zookeeper bash -c "zkServer.sh status" 2>&1 | grep -q 'Mode: standalone' && break
    sleep 1s
done

# create acl
docker exec -t zookeeper bash -c "zkCli.sh <<EOF
addauth digest $ZOOKEEPER_USER:$ZOOKEEPER_PASSWORD
deleteall /dubbo
create /dubbo data auth:$ZOOKEEPER_USER:$ZOOKEEPER_PASSWORD:cdwra
create /dubbo/metadata
create /dubbo/config
create /services
EOF
"

# cloudlego
docker-compose -f cloudlego.yml up -d