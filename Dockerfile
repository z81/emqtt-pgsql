FROM ubuntu

RUN apt-get update && \
    apt-get install -y unzip wget && \
    wget http://emqtt.io/downloads/latest/ubuntu && \
    unzip ubuntu && \
    rm ubuntu && \
    apt-get remove -y unzip wget && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /emqttd
VOLUME ["/emqttd/etc", "/emqttd/data", "/emqttd/plugins"]

ADD ./start.sh /emqttd/start.sh
RUN chmod +x /emqttd/start.sh

ADD ./table.sql /opt/emqttd/table.sql

WORKDIR /opt/emqttd

# start emqttd and initial environments
CMD ["/opt/emqttd/start.sh"]

# emqttd will occupy these port:
# - 1883 port for MQTT
# - 8883 port for MQTT(SSL)
# - 8083 for WebSocket/HTTP
# - 8084 for WSS/HTTPS
# - 18083 for dashboard
# - 4369 for port mapping
# - 6000-6999 for distributed node
EXPOSE 1883 8883 8083 8084 18083 4369 6000-6999
