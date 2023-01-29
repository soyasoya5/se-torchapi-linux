#! /bin/sh

function runUser(){
  export WINEARCH=win64
  export DISPLAY=":99"
  export WINEPREFIX=/wineprefix
  runuser --user wine \
    --whitelist-environment DISPLAY,WINEARCH,WINEPREFIX \
    --shell bash \
    -- "${1}"
}

function setupWineVNC(){
  if [ ! -f /app/.Xauthority ]; then
    runUser "touch /app/{x11vnc.log,.Xauthority}"
  fi

  runUser "Xvfb ${DISPLAY} -screen 0 1280x1024x24 -ac -br -auth /app/.Xauthority &"
  runUser "x11vnc -display WAIT${DISPLAY} -forever -autoport 5900 -auth /app/.Xauthority -nopw -o /app/x11vnc.log -bg &"

  echo "Waiting 5 seconds for X server to initialize..."
  sleep 5

  runUser "openbox &"

  # Open up file browser
  runUser "winefile"
}

function setupTorchAPIServer() {
  # Run with absolute path-reference from inside of docker container
  runUser "wine z:/app/torch-server/Torch.Server.exe"
}

function main(){
  setupTorchAPIServer &
  setupWineVNC
}

main
