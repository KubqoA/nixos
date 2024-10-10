{config, ...}: let
  ipv4 = "116.203.250.61";
  ipv6 = "2a01:4f8:c012:58f4::";
in {
  networking = {
    hostName = "organ";
    domain = "jakubarbet.me";
    useDHCP = false;
    nameservers = ["1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001"];
    firewall.enable = true;
  };

  services.resolved.enable = false;

  # static ip configuration for hetzner cloud
  # https://docs.hetzner.com/cloud/servers/static-configuration/
  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = "enp1s0";
      networkConfig.DHCP = "no";
      address = [
        "${config.ipv4}/32"
        "${config.ipv6}/64"
      ];
      routes = [
        {
          Gateway = "172.31.1.1";
          GatewayOnLink = true;
        }
        {Gateway = "fe80::1";}
      ];
    };
  };
}
