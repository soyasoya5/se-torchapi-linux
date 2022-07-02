## Space Engineers TorchAPI on Linux Docker
---
Couldn't download mods and plugins with the dockerized [Keen dedicated server](https://github.com/mmmaxwwwell/space-engineers-dedicated-docker-linux) and TorchAPI on Linux was not officially supported. I didn't really want to pay for a Windows server either, so I decided to get TorchAPI working for Linux.

![TorchAPI GUI in VNC](images/torch.png)

## Requirements
---
- Docker
- docker-compose
- unzip
- wget
- Any VNC viewer (vncviewer for Linux / MobaXTerm for Windows)
- \*Important but not necessary\* - Firewall to block unknown connections to VNC port 5900

## Features
---
- **Unsecured VNC access (Recommend to access through SSH port forwarding only)**
- No DE/WM for slim image, don't need one anyways
- Wine 6
- Easy access to World data for manual backups and editing

## Usage
---
1. Clone this repo
2. Run `./start`
3. Run `./stop` to stop & remove container, the torch server data won't be removed.

## Notes
---
- SSH to server with the option `-L 5900:127.0.0.1:5900` to be able to access VNC through your localhost
- May have to restart TorchAPI after creating a new instance for it to show up in the GUI
- Attach to the container's CLI by running this command: `docker exec -it se-torchapi /bin/bash`
- Use `htop` or `killall Torch.Server.exe` to close the windows
- File browser can be displayed by running `winefile` in the container's CLI
- The already opened file browser's user id is 1000


## Credits & Acknowledgements
---
- [mmmaxwwwell](https://github.com/mmmaxwwwell) for base wine image & winetricks script
