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

      # Bluetooth configuration
      media-session.config.bluez-monitor.properties = mkIf config.hw.bluetooth.enable {
        bluez5.msbc-support = true;
        bluez5.sbc-xq-support = true;
      };

      media-session.config.bluez-monitor.rules = mkIf config.hw.bluetooth.enable [
        {
          # Matches all cards
          matches = [ { "device.name" = "~bluez_card.*"; } ];
          actions = {
            "update-props" = {
              "bluez5.auto-connect" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
              "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
              # mSBC is not expected to work on all headset + adapter combinations.
              "bluez5.msbc-support" = true;
              # SBC-XQ is not expected to work on all headset + adapter combinations.
              "bluez5.sbc-xq-support" = true;
            };
          };
        }
        {
          matches = [
            # Matches all sources
            { "node.name" = "~bluez_input.*"; }
            # Matches all outputs
            { "node.name" = "~bluez_output.*"; }
          ];
          actions = {
            "node.pause-on-idle" = false;
          };
        }
      ];
    };
  };
}
