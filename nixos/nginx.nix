{ config, ... }: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "emanueljohnsongodin@gmail.com";
  };

  networking.firewall.allowedTCPPorts = [ 80 81 443 ];
  # factorio
  networking.firewall.allowedUDPPorts = [ 34197 ];

  services.nginx =
    let
      domain = "emanueljg.com";
      mkFQDN = subdomain: "${subdomain}.${domain}";
      defaults = {
        enableACME = true;
        forceSSL = true;
      };
      mkDefaultsLocation = port: {
        locations = {
          "/".proxyPass = "http://127.0.0.1:${builtins.toString port}";
        };
      };

      mkAllDefaults = port: defaults // (mkDefaultsLocation port);
    in
    {
      enable = true;
      virtualHosts = {
        ${mkFQDN "lib"} = mkAllDefaults "8096";
        ${mkFQDN "yt"} = mkAllDefaults "3000";
        ${mkFQDN "navi"} = mkAllDefaults "4533";
        ${mkFQDN "kavita"} = (mkAllDefaults config.services.kavita.settings.Port) // {
          extraConfig = ''
            proxy_set_header Host $host;
          '';
        };
        ${mkFQDN "live"} = defaults // {
          locations = {
            "/".proxyPass = "http://192.168.0.219:80";
          };
        };
        # ${mkFQDN "sonarr"} = mkAllDefaults "8989";
        "dir.void" = {
          locations = {
            "/games" = {
              root = "/mnt/data";
              extraConfig = ''
                allow 192.168.0.0/24;
                deny all;
                autoindex on;
              '';
            };
          };
        };
      };
    };
}
