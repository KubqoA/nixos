{
  config,
  inputs,
  lib,
  ...
}: let
  domain = "jakubarbet.me";
in {
  imports = [inputs.simple-nixos-mailserver.nixosModule];

  age.secrets =
    lib._.defineSecrets ["organ-sasl-passwd"] {
    };

  mailserver = {
    enable = true;
    fqdn = "mail.${domain}";
    domains = [domain];
    certificateScheme = "acme";
    localDnsResolver = lib.mkIf config.services.bind.enable false;
    dkimSigning = false;
    loginAccounts = {
      "hi@${domain}" = {
        hashedPasswordFile = config.users.users.jakub.hashedPasswordFile;
        aliases = ["jakub@${domain}" "postmaster@${domain}" "hostmaster@${domain}"];
      };
    };
  };

  services = {
    nginx.virtualHosts."mail.${domain}" = {
      enableACME = true;
      forceSSL = true;
      serverAliases = ["autoconfig.${domain}" "autodiscover.${domain}"];
      locations."/" = {
        proxyPass = "http://localhost:8080/";
      };
    };
    postfix = {
      mapFiles."sasl_passwd" = config.age.secrets.organ-sasl-passwd.path;
      extraConfig = ''
        smtp_sasl_auth_enable = yes
        smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
        smtp_sasl_security_options = noanonymous
        relayhost = smtp.eu.mailgun.org:587
      '';
    };
  };
}