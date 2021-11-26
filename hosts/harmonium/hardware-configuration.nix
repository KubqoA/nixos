# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/06d00c60-3da4-438d-bee3-4ce59186bcef";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

  boot.initrd.luks.reusePassphrases = true;
  boot.initrd.luks.devices."swap" = {
    allowDiscards = true;
    device = "/dev/disk/by-uuid/e3e86662-14ea-4df7-822d-6a13657b2d2b";
  };
  boot.initrd.luks.devices."data" = {
    allowDiscards = true;
    device = "/dev/disk/by-uuid/6924e010-b0e1-48e6-b5bc-8465c5089ff8";
  };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/06d00c60-3da4-438d-bee3-4ce59186bcef";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/06d00c60-3da4-438d-bee3-4ce59186bcef";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/06d00c60-3da4-438d-bee3-4ce59186bcef";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/06d00c60-3da4-438d-bee3-4ce59186bcef";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1AD2-9F59";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/f08da8a0-7941-4ee3-904b-597e1cfd7a1c"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
