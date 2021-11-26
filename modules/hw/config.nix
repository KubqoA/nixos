{ config, lib, ... }:

with lib;
{
  options.hw = with types; {
    audio.enable = _.mkBoolOpt false;
    bluetooth.enable = _.mkBoolOpt false;
    graphics.enable = _.mkBoolOpt false;
  };

  config.hardware.bluetooth.enable = config.hw.bluetooth.enable;
}
