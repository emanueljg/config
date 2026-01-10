{ custom, ... }:
{
  imports = [ custom.udiskie ];

  custom.services.udiskie.enable = true;

  services.udisks2 = {
    enable = true;
  };

}
