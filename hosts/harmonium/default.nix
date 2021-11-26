{ config, inputs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen2
  ];

  users.users.root.hashedPassword = "$6$rounds=500000$Jx1CAQIK.v1i6HBp$FfD3DdzV9tdM1DC1HZxqddB2v9TEs7MFbQvtSB0gLDlXTZ8SRmIsoIb5YJVBmm4ouWERUL56Ca16zoDNZOXGf0";

  username = "jarbet";
  fullname = "Jakub Arbet";
  email = "hi@jakubarbet.me";
  gpgkey = "990D46A4F8E4A895ACA14D6D883E485DBD16738C";
  sshkey = "66A1D2FE61E386994B769DB98B3DB907AA55B84B";
  user.hashedPassword = "$6$rounds=500000$XPUDTNiFDC4At5Uz$pry1ydIuAvvP0ZF/GP5cRUQ9jLWndNQdk4uTJd6s0fA5TlEmyIlz7VylhVoAwswCzhw7LK/6insHt9elMOkE61";

  networking.hostName = "harmonium";
  darlingErasure.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Bratislava";

  # OS feel
  desktop = true;
  ui.theme = "atmosphere";
  shell.zsh.enable = true;

  # HW
  hw.audio.enable = true;
  hw.bluetooth.enable = true;
  hw.graphics.enable = true;
  programs.light.enable = true;
  networking.networkmanager.enable = true;

  services.fprintd.enable = true;
  services.fwupd.enable = true;
}
