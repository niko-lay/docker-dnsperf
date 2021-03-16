FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt  update && \
	apt  install -y --no-install-recommends wget ca-certificates apt-transport-https gnupg && \
	echo "deb http://pkg.dns-oarc.net/debian buster main" >>  /etc/apt/sources.list.d/dns-oarc.list && \
 	wget -q 'https://pkg.dns-oarc.net/dns-oarc.distribution.key.gpg' -O - | apt-key add - && \
	apt-get update && \
	apt-get install -y dnsperf && \
	apt remove -y --auto-remove  wget gnupg && \
	rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]