{
  imports = [ ./local/udiskie.nix ];

  services.udisks2 = {
    enable = true;
  };

  local.udiskie.enable = true;
}
