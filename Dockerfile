FROM jboss/base-jdk:8
MAINTAINER fabric8.io (http://fabric8.io/)

WORKDIR ~
USER root

ADD http://download.go.cd/gocd-rpm/go-server-14.4.0-1356.noarch.rpm /tmp/go-server.rpm
ADD http://download.go.cd/gocd-rpm/go-agent-14.4.0-1356.noarch.rpm /tmp/go-agent.rpm

RUN rpm -i /tmp/go-server.rpm && \
	rpm -i /tmp/go-agent.rpm 

RUN sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-server /etc/default/go-agent && \
	echo 'export GO_SERVER_SYSTEM_PROPERTIES="-DpluginLocationMonitor.sleepTimeInSecs=1"' >>/etc/default/go-server

EXPOSE 8153 8154

USER go

CMD ["/usr/share/go-server/server.sh", "/usr/share/go-agent/agent.sh"]
