{ pkgs ? import <nixpkgs> { } }:

pkgs.writeScriptBin "nordvpn-status" ''
#!${pkgs.stdenv.shell}

if ! command -v nordvpn &> /dev/null; then
    exit
fi

tooltip=$(nordvpn status | sed -n '/Current server:\|Your new IP:/s/.*: //p' | sed '{N;s/\n/ /}')
status=$(nordvpn status | sed -n '/Status:/s/.*: //p')

if [ "$status" = "Connected" ]; then
    echo '{"text": "Connected", "tooltip": "'"$tooltip"'", "class": "connected"}'
else
    echo '{"text": "Disonnected", "tooltip": "Disconnected", "class": "disconnected"}'
fi
''
