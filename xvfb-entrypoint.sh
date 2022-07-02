#! /bin/sh

export WINEARCH=win64
export WINEPREFIX=/wineprefix
export DISPLAY=":99"

if [ ! -f /app/.Xauthority ]; then
  runuser -u wine -- touch /app/x11vnc.log /app/.Xauthority
fi
runuser -u wine -- bash -c 'Xvfb :99 -screen 0 1280x1024x24 -ac -br -auth /app/.Xauthority &'
runuser -u wine -- bash -c 'x11vnc -display WAIT:99 -forever -autoport 5900 -auth /app/.Xauthority -nopw -o /app/x11vnc.log -bg &'

echo "Waiting 5 seconds for X server to initialize..."
sleep 5

# Open up file browser
runuser -u wine -- bash -c 'DISPLAY=":99" winefile'
