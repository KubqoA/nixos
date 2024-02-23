# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.supportedFilesystems = ["btrfs"];
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.consoleLogLevel = 3;
  boot.kernelParams = ["quiet" "udev.log_priority=3"];

  boot.initrd.luks.devices."swap-enc" = {
    allowDiscards = true;
    device = "/dev/disk/by-uuid/beea79c0-ea69-4535-b60b-fc729dfcef34";
  };
  boot.initrd.luks.devices."enc" = {
    allowDiscards = true;
    device = "/dev/disk/by-uuid/75787292-6aed-485b-8e02-09b64cf922ce";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/42302778-a8e2-47b1-813e-7542012046d5";
    fsType = "btrfs";
    options = ["subvol=root" "compress=zstd" "noatime"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/42302778-a8e2-47b1-813e-7542012046d5";
    fsType = "btrfs";
    options = ["subvol=home" "compress=zstd" "noatime"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/42302778-a8e2-47b1-813e-7542012046d5";
    fsType = "btrfs";
    options = ["subvol=nix" "compress=zstd" "noatime"];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/42302778-a8e2-47b1-813e-7542012046d5";
    fsType = "btrfs";
    options = ["subvol=persist" "compress=zstd" "noatime"];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/42302778-a8e2-47b1-813e-7542012046d5";
    fsType = "btrfs";
    options = ["subvol=log" "compress=zstd" "noatime"];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1AD2-9F59";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/5125afb9-9ae6-4dae-99b5-3c3ee3da0e51";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}