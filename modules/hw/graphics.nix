{ config, lib, pkgs, ... }:

with lib;
{
  config = mkIf config.hw.graphics.enable {
    hardware.opengl.enable = true;
    hardware.opengl.extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
}
