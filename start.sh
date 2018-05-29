#!/bin/sh
## EMQ docker image start script
# Huang Rui <vowstar@gmail.com>

## EMQ Base settings
# Base settings in /opt/emqttd/etc/emq.conf

if [ x"${EMQ_NAME}" = x ]
then
EMQ_NAME=$(hostname)
echo "EMQ_NAME=${EMQ_NAME}"
fi

if [ x"${EMQ_HOST}" = x ]
then
EMQ_HOST=$(cat /etc/hosts | grep $(hostname) | awk '{print $1}')
echo "EMQ_HOST=${EMQ_HOST}"
fi

if [ x"${EMQ_NODE_NAME}" = x ]
then
EMQ_NODE_NAME="${EMQ_NAME}@${EMQ_HOST}"
echo "EMQ_NODE_NAME=${EMQ_NODE_NAME}"
fi
sed -i -e "s/^#*\s*node.name\s*=\s*.*@.*/node.name = ${EMQ_NODE_NAME}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_NODE_COOKIE}" = x ]
then
EMQ_NODE_COOKIE="emq_dist_cookie"
echo "EMQ_NODE_COOKIE=${EMQ_NODE_COOKIE}"
fi
sed -i -e "s/^#*\s*node.cookie\s*=\s*.*/node.cookie = ${EMQ_NODE_COOKIE}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_PROCESS_LIMIT}" = x ]
then
EMQ_PROCESS_LIMIT=2097152
echo "EMQ_PROCESS_LIMIT=${EMQ_PROCESS_LIMIT}"
fi
sed -i -e "s/^#*\s*node.process_limit\s*=\s*.*/node.process_limit = ${EMQ_PROCESS_LIMIT}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_MAX_PORTS}" = x ]
then
EMQ_MAX_PORTS=1048576
echo "EMQ_MAX_PORTS=${EMQ_MAX_PORTS}"
fi
sed -i -e "s/^#*\s*node.max_ports\s*=\s*.*/node.max_ports = ${EMQ_MAX_PORTS}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_LOG_CONSOLE}" = x ]
then
EMQ_LOG_CONSOLE="file"
echo "EMQ_LOG_CONSOLE=${EMQ_LOG_CONSOLE}"
fi
sed -i -e "s/^#*\s*log.console\s*=\s*.*/log.console = ${EMQ_LOG_CONSOLE}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_LOG_LEVEL}" = x ]
then
EMQ_LOG_LEVEL="error"
echo "EMQ_LOG_LEVEL=${EMQ_LOG_LEVEL}"
fi
sed -i -e "s/^#*\s*log.console.level\s*=\s*.*/log.console.level = ${EMQ_LOG_LEVEL}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_ALLOW_ANONYMOUS}" = x ]
then
EMQ_ALLOW_ANONYMOUS="false"
echo "EMQ_ALLOW_ANONYMOUS=${EMQ_ALLOW_ANONYMOUS}"
fi
sed -i -e "s/^#*\s*mqtt.allow_anonymous\s*=\s*.*/mqtt.allow_anonymous = ${EMQ_ALLOW_ANONYMOUS}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_TCP_PORT}" = x ]
then
EMQ_TCP_PORT=1883
echo "EMQ_TCP_PORT=${EMQ_TCP_PORT}"
fi
sed -i -e "s/^#*\s*mqtt.listener.tcp\s*=\s*.*/mqtt.listener.tcp = ${EMQ_TCP_PORT}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_TCP_ACCEPTORS}" = x ]
then
EMQ_TCP_ACCEPTORS=64
echo "EMQ_TCP_ACCEPTORS=${EMQ_TCP_ACCEPTORS}"
fi
sed -i -e "s/^#*\s*mqtt.listener.tcp.acceptors\s*=\s*.*/mqtt.listener.tcp.acceptors = ${EMQ_TCP_ACCEPTORS}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_TCP_MAX_CLIENTS}" = x ]
then
EMQ_TCP_MAX_CLIENTS=1000000
echo "EMQ_TCP_MAX_CLIENTS=${EMQ_TCP_MAX_CLIENTS}"
fi
sed -i -e "s/^#*\s*mqtt.listener.tcp.max_clients\s*=\s*.*/mqtt.listener.tcp.max_clients = ${EMQ_TCP_MAX_CLIENTS}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_SSL_PORT}" = x ]
then
EMQ_SSL_PORT=8883
echo "EMQ_SSL_PORT=${EMQ_SSL_PORT}"
fi
sed -i -e "s/^#*\s*mqtt.listener.ssl\s*=\s*.*/mqtt.listener.ssl = ${EMQ_SSL_PORT}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_SSL_ACCEPTORS}" = x ]
then
EMQ_SSL_ACCEPTORS=32
echo "EMQ_SSL_ACCEPTORS=${EMQ_SSL_ACCEPTORS}"
fi
sed -i -e "s/^#*\s*mqtt.listener.ssl.acceptors\s*=\s*.*/mqtt.listener.ssl.acceptors = ${EMQ_SSL_ACCEPTORS}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_SSL_MAX_CLIENTS}" = x ]
then
EMQ_SSL_MAX_CLIENTS=500000
echo "EMQ_SSL_MAX_CLIENTS=${EMQ_SSL_MAX_CLIENTS}"
fi
sed -i -e "s/^#*\s*mqtt.listener.ssl.max_clients\s*=\s*.*/mqtt.listener.ssl.max_clients = ${EMQ_SSL_MAX_CLIENTS}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_HTTP_PORT}" = x ]
then
EMQ_HTTP_PORT=8083
echo "EMQ_HTTP_PORT=${EMQ_HTTP_PORT}"
fi
sed -i -e "s/^#*\s*mqtt.listener.http\s*=\s*.*/mqtt.listener.http = ${EMQ_HTTP_PORT}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_HTTP_ACCEPTORS}" = x ]
then
EMQ_HTTP_ACCEPTORS=64
echo "EMQ_HTTP_ACCEPTORS=${EMQ_HTTP_ACCEPTORS}"
fi
sed -i -e "s/^#*\s*mqtt.listener.http.acceptors\s*=\s*.*/mqtt.listener.http.acceptors = ${EMQ_HTTP_ACCEPTORS}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_HTTP_MAX_CLIENTS}" = x ]
then
EMQ_HTTP_MAX_CLIENTS=1000000
echo "EMQ_HTTP_MAX_CLIENTS=${EMQ_HTTP_MAX_CLIENTS}"
fi
sed -i -e "s/^#*\s*mqtt.listener.http.max_clients\s*=\s*.*/mqtt.listener.http.max_clients = ${EMQ_HTTP_MAX_CLIENTS}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_HTTPS_PORT}" = x ]
then
EMQ_HTTPS_PORT=8084
echo "EMQ_HTTPS_PORT=${EMQ_HTTPS_PORT}"
fi
sed -i -e "s/^#*\s*mqtt.listener.https\s*=\s*.*/mqtt.listener.https = ${EMQ_HTTPS_PORT}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_HTTPS_ACCEPTORS}" = x ]
then
EMQ_HTTPS_ACCEPTORS=32
echo "EMQ_HTTPS_ACCEPTORS=${EMQ_HTTPS_ACCEPTORS}"
fi
sed -i -e "s/^#*\s*mqtt.listener.https.acceptors\s*=\s*.*/mqtt.listener.https.acceptors = ${EMQ_HTTPS_ACCEPTORS}/g" /opt/emqttd/etc/emq.conf

if [ x"${EMQ_HTTPS_MAX_CLIENTS}" = x ]
then
EMQ_HTTPS_MAX_CLIENTS=1000000
echo "EMQ_HTTPS_MAX_CLIENTS=${EMQ_HTTPS_MAX_CLIENTS}"
fi
sed -i -e "s/^#*\s*mqtt.listener.https.max_clients\s*=\s*.*/mqtt.listener.https.max_clients = ${EMQ_HTTPS_MAX_CLIENTS}/g" /opt/emqttd/etc/emq.conf


if [ x"${EMQ_MAX_PACKET_SIZE}" = x ]
then
EMQ_MAX_PACKET_SIZE="64KB"
echo "EMQ_MAX_PACKET_SIZE=${EMQ_MAX_PACKET_SIZE}"
fi
sed -i -e "s/^#*\s*mqtt.max_packet_size\s*=\s*.*/mqtt.max_packet_size = ${EMQ_MAX_PACKET_SIZE}/g" /opt/emqttd/etc/emq.conf

## EMQ Plugin load settings
# Plugins loaded by default

if [ x"${EMQ_LOADED_PLUGINS}" = x ]
then
EMQ_LOADED_PLUGINS="emq_recon,emq_dashboard,emq_mod_presence,emq_mod_retainer,emq_auth_pgsql"
echo "EMQ_LOADED_PLUGINS=${EMQ_LOADED_PLUGINS}"
fi
# First, remove special char at header
# Next, replace special char to ".\n" to fit emq loaded_plugins format
echo $(echo "${EMQ_LOADED_PLUGINS}."|sed -e "s/^[^A-Za-z0-9_]\{1,\}//g"|sed -e "s/[^A-Za-z0-9_]\{1,\}/\.\n/g") > /opt/emqttd/data/loaded_plugins

## EMQ Plugins setting

## TODO: Add plugins settings


: ${EMQ_AUTH_PGSQL_SSL:="false"}
: ${EMQ_AUTH_PGSQL_SUPERQUERY:="select is_superuser from mqtt_user where username = '%u' limit 1"}
: ${EMQ_AUTH_PGSQL_ACLQUERY:="select allow, ipaddr, username, clientid, access, topic from mqtt_acl where ipaddr = '%a' or username = '%u' or username = '$all' or clientid = '%c'"}
: ${EMQ_AUTH_PGSQL_AUTHQUERY:="select password from mqtt_user where username = '%u' limit 1"}
: ${EMQ_AUTH_PGSQL_PASSWD_HASH:="salt sha256"}
: ${EMQ_AUTH_PGSQL_NOMATCH:="deny"}
: ${EMQ_AUTH_PGSQL_ENCODING:="utf8"}
: ${EMQ_AUTH_PGSQL_USERNAME:="root"}
: ${EMQ_AUTH_PGSQL_PASSWORD:="\"\""}
: ${EMQ_AUTH_PGSQL_DATABASE:="emqtt"}
: ${EMQ_AUTH_PGSQL_POOL:="8"}
: ${EMQ_AUTH_PGSQL_HOST:="127.0.0.1"}
: ${EMQ_AUTH_PGSQL_PORT:="5432"}

sed -e "
    s/^#*\s*auth.pgsql.server\s*=\s*.*/auth.pgsql.server = ${EMQ_AUTH_PGSQL_HOST}:${EMQ_AUTH_PGSQL_PORT}/g;
    s/^#*\s*auth.pgsql.pool\s*=\s*.*/auth.pgsql.pool = ${EMQ_AUTH_PGSQL_POOL}/g;
    s/^#*\s*auth.pgsql.database\s*=\s*.*/auth.pgsql.database = ${EMQ_AUTH_PGSQL_DATABASE}/g;
    s/^#*\s*auth.pgsql.password\s*=\s*.*/auth.pgsql.password = ${EMQ_AUTH_PGSQL_PASSWORD}/g;
    s/^#*\s*auth.pgsql.username\s*=\s*.*/auth.pgsql.username = ${EMQ_AUTH_PGSQL_USERNAME}/g;
    s/^#*\s*auth.pgsql.encoding\s*=\s*.*/auth.pgsql.encoding = ${EMQ_AUTH_PGSQL_ENCODING}/g;
    s/^#*\s*auth.pgsql.acl_nomatch\s*=\s*.*/auth.pgsql.acl_nomatch = ${EMQ_AUTH_PGSQL_NOMATCH}/g;
    s/^#*auth.pgsql.password_hash\s*=\s*.*/auth.pgsql.password_hash = ${EMQ_AUTH_PGSQL_PASSWD_HASH}/g;
    s/^#*\s*auth.pgsql.auth_query\s*=\s*.*/auth.pgsql.auth_query = ${EMQ_AUTH_PGSQL_AUTHQUERY}/g;
    s/^#*\s*auth.pgsql.acl_query\s*=\s*.*/auth.pgsql.acl_query = ${EMQ_AUTH_PGSQL_ACLQUERY}/g;
    s/^#*\s*auth.pgsql.super_query\s*=\s*.*/auth.pgsql.super_query = ${EMQ_AUTH_PGSQL_SUPERQUERY}/g;
    s/^#*\s*auth.pgsql.ssl\s*=\s*.*/auth.pgsql.ssl = ${EMQ_AUTH_PGSQL_SSL}/g" -i /opt/emqttd/etc/plugins/emq_auth_pgsql.conf

cat /opt/emqttd/etc/plugins/emq_auth_pgsql.conf
## EMQ Main script
# Start and run emqttd, and when emqttd crashed, this container will stop

apk add --no-cache postgresql

port=$(echo $EMQ_AUTH_PGSQL_SERVER | awk -F ':' '{print $2}')
PGPASSWORD=$EMQ_AUTH_PGSQL_PASSWORD psql --port $port --file table.sql --host ${EMQ_AUTH_PGSQL_SERVER%:*} --username $EMQ_AUTH_PGSQL_USERNAME --dbname $EMQ_AUTH_PGSQL_DATABASE

/opt/emqttd/bin/emqttd start

# wait and ensure emqttd status is running
WAIT_TIME=0
while [ x$(/opt/emqttd/bin/emqttd_ctl status |grep 'is running'|awk '{print $1}') = x ]
do
    sleep 1
    echo '['$(date -u +"%Y-%m-%dT%H:%M:%SZ")']:waiting emqttd'
    WAIT_TIME=`expr ${WAIT_TIME} + 1`
    if [ ${WAIT_TIME} -gt 5 ]
    then
        echo '['$(date -u +"%Y-%m-%dT%H:%M:%SZ")']:timeout error'
        exit 1
    fi
done

echo '['$(date -u +"%Y-%m-%dT%H:%M:%SZ")']:emqttd start'

# monitor emqttd is running, or the docker must stop to let docker PaaS know
# warning: never use infinite loops such as `` while true; do sleep 1000; done`` here
#          you must let user know emqtt crashed and stop this container,
#          and docker dispatching system can known and restart this container.
IDLE_TIME=0
while [ x$(/opt/emqttd/bin/emqttd_ctl status |grep 'is running'|awk '{print $1}') != x ]
do  
    IDLE_TIME=`expr ${IDLE_TIME} + 1`
    echo '['$(date -u +"%Y-%m-%dT%H:%M:%SZ")']:emqttd running'
    sleep 20
done


tail $(ls /opt/emqttd/log/*)

echo '['$(date -u +"%Y-%m-%dT%H:%M:%SZ")']:emqttd stop'