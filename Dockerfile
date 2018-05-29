FROM alpine:3.7

MAINTAINER Huang Rui <vowstar@gmail.com>, Turtle <turtled@emqtt.io>

ENV EMQ_VERSION=v2.3.9

RUN set -ex \
    # add build deps, remove after build
    && apk --no-cache add --virtual .build-deps \
        build-base \
        # gcc \
        # make \
        bsd-compat-headers \
        perl \
        erlang \
        erlang-public-key \
        erlang-syntax-tools \
        erlang-erl-docgen \
        #erlang-gs \
        erlang-observer \
        erlang-ssh \
        #erlang-ose \
        erlang-cosfiletransfer \
        erlang-runtime-tools \
        erlang-os-mon \
        erlang-tools \
        erlang-cosproperty \
        erlang-common-test \
        erlang-dialyzer \
        erlang-edoc \
        erlang-otp-mibs \
        erlang-crypto \
        erlang-costransaction \
        erlang-odbc \
        erlang-inets \
        erlang-asn1 \
        erlang-snmp \
        erlang-erts \
        erlang-et \
        erlang-cosnotification \
        erlang-xmerl \
        #erlang-typer \
        erlang-coseventdomain \
        erlang-stdlib \
        erlang-diameter \
        erlang-hipe \
        erlang-ic \
        erlang-eunit \
        #erlang-webtool \
        erlang-mnesia \
        erlang-erl-interface \
        #erlang-test-server \
        erlang-sasl \
        erlang-jinterface \
        erlang-kernel \
        erlang-orber \
        erlang-costime \
        #erlang-percept \
        erlang-dev \
        erlang-eldap \
        erlang-reltool \
        erlang-debugger \
        erlang-ssl \
        erlang-megaco \
        erlang-parsetools \
        erlang-cosevent \
        erlang-compiler \
    # add fetch deps, remove after build
    && apk add --no-cache --virtual .fetch-deps \
        git \
        wget \
    # add run deps, never remove
    && apk add --no-cache --virtual .run-deps \
        ncurses-terminfo-base \
        ncurses-terminfo \
        ncurses-libs \
        readline \
    # add latest rebar
    && git clone -b ${EMQ_VERSION} https://github.com/emqtt/emq-relx.git /emqttd_g \
    && cd /emqttd_g \
    && make \
    && mkdir -p /emqttd && mv /emqttd_g/_rel/emqttd /emqttd \
    && cd / && rm -rf /emqttd_g \
    && chmod +x /emqttd/start.sh \
    && ln -s /emqttd/bin/* /usr/local/bin/ \
    # removing fetch deps and build deps
    && apk --purge del .build-deps .fetch-deps \
    && rm -rf /var/cache/apk/*

WORKDIR /emqttd

RUN adduser -D -u 1000 emqtt

RUN chgrp -Rf root /emqttd && chmod -Rf g+w /emqttd \
      && chown -Rf emqtt /emqttd

USER emqtt

VOLUME ["/emqttd/log", "/emqttd/data", "/emqttd/lib", "/emqttd/etc"]

ADD ./start.sh /emqttd/start.sh
RUN chmod +x /emqttd/start.sh

ADD ./table.sql /emqttd/table.sql

# start emqttd and initial environments
CMD ["/emqttd/start.sh"]

# emqttd will occupy these port:
# - 1883 port for MQTT
# - 8883 port for MQTT(SSL)
# - 8083 for WebSocket/HTTP
# - 8084 for WSS/HTTPS
# - 18083 for dashboard
# - 4369 for port mapping
# - 6000-6999 for distributed node
EXPOSE 1883 8883 8083 8084 18083 4369 6000-6999
