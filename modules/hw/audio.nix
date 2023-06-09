{ config, lib, ... }:

with lib;
{
  config = mkIf config.hw.audio.enable {
    security.rtkit.enable = true;

    # Enable pipewire for audio handling
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      # alsa.support32Bit = true;
      pulse.enable = true;

      wireplumber.enable = true;
    };

    # Bluetooth configuration
    environment.etc = mkIf config.hw.bluetooth.enable {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
bluez_monitor.properties = {
  ["bluez5.enable-sbc-xq"] = true,
  ["bluez5.enable-msbc"] = true,
  ["bluez5.enable-hw-volume"] = true,
  ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
}
      '';
    };
  };
}
