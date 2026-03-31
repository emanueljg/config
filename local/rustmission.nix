{
  custom,
  pkgs,
  config,
  ...
}:
{
  imports = [ custom.rustmission ];

  custom.programs.rustmission =
    let
      host = config.services.transmission.settings.rpc-bind-address;
      port = config.services.transmission.settings.rpc-port;
    in
    {
      enable = true;
      rpcUrl = "http://${host}:${builtins.toString port}/transmission/rpc";
      # settions = {
      #   r
      # };
    };
}
