# aria2
nssm install aria2 "C:\ProgramData\chocolatey\bin\aria2c.exe" --conf-path=`"$env:USERPROFILE\.aria2\aria2.conf`"

# aria2-webui
nssm install aria2.webui "$env:USERPROFILE\go\bin\caddy.exe" -port 9999
nssm set aria2.webui AppDirectory "$env:USERPROFILE\webui-aria2"

# syncthing
nssm install syncthing "C:\ProgramData\chocolatey\bin\syncthing.exe" --no-browser --no-console

# Start services
nssm start aria2
nssm start aria2.webui
nssm start syncthing

