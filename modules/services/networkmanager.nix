{ config, lib, ... }:

with lib;
{
  config = mkIf config.networking.networkmanager.enable {
    networking.networkmanager.insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
    networking.networkmanager.wifi.backend = "iwd";
  };
}
