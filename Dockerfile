FROM mmmaxwwwell/wine6:latest

RUN apt update --allow-releaseinfo-change \
    && DEBIAN_FRONTEND="noninteractive" \
    apt install -y procps htop winbind x11vnc net-tools openbox \
    && apt autoclean \
    && apt autoremove -y

COPY ./install_winetricks /scripts

RUN chmod +x /scripts/install_winetricks \
    && mkdir /wineprefix /app \
    && chown -R wine:wine /wineprefix /app

WORKDIR /app
RUN runuser -u wine -- bash -c 'WINEARCH=win64 WINEPREFIX=/wineprefix /scripts/install_winetricks'

COPY ./xvfb-entrypoint.sh /
RUN chmod +x /xvfb-entrypoint.sh

ENTRYPOINT ["sh", "/xvfb-entrypoint.sh"]

