{ lib, ... }:
{
  options.custom.lan = lib.mkOption {
    type = with lib.types; nullOr str;
    default = null;
  };
}
