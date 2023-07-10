FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive

ADD https://pkg.dns-oarc.net/dns-oarc.distribution.key.gpg /etc/apt/trusted.gpg.d/dns-oarc.asc

RUN chmod +r  /etc/apt/trusted.gpg.d/dns-oarc.asc && \
	echo "deb http://pkg.dns-oarc.net/debian $(. /etc/os-release; printf '%s\n' "$VERSION_CODENAME";) main" >>  /etc/apt/sources.list.d/dns-oarc.list && \
	apt-get update && \
	apt-get install -y dnsperf && \
	rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]