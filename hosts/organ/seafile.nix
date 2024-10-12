{config, ...}: {
  services = {
    nginx.virtualHosts."drive.jakubarbet.me" = {
      enableACME = true;
      forceSSL = true;
      locations."/".proxyPass = "http://unix:/run/seahub/gunicorn.sock";
      locations."/seafhttp" = {
        proxyPass = "http://unix:/run/seafile/server.sock";
        extraConfig = ''
          rewrite ^/seafhttp(.*)$ $1 break;
          client_max_body_size 0;
          proxy_connect_timeout  36000s;
          proxy_read_timeout  36000s;
          proxy_send_timeout  36000s;
          send_timeout  36000s;
          proxy_http_version 1.1;
        '';
      };
    };

    seafile = {
      enable = true;
      ccnetSettings.General.SERVICE_URL = "https://drive.jakubarbet.me";
      seafileSettings.fileserver.host = "unix:/run/seafile/server.sock";
      adminEmail = "hi@jakubarbet.me";
      initialAdminPassword = "hesielko";

      seahubExtraConf = ''
        CSRF_TRUSTED_ORIGINS = ["https://drive.jakubarbet.me"]
      '';
    };
  };
}
