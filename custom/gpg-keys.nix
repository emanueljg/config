{ lib, config, ... }:
let

  mkRegexCheckType = pattern: with lib.types; addCheck str (x: (builtins.match pattern x) != null);
  masterKeyRegexType = mkRegexCheckType "[A-Z0-9]{40}";
  subKeyRegexType = mkRegexCheckType "[A-Z0-9]{40}!";

  subKeyType =
    with lib.types;
    attrsOf (
      submodule (
        { name, ... }:
        {
          options = {
            host = lib.mkOption {
              readOnly = true;
              type = lib.types.str;
              default = name;
            };
            sign = lib.mkOption {
              type = subKeyRegexType;
            };
            encrypt = lib.mkOption {
              type = subKeyRegexType;
            };
          };
        }
      )
    );

  masterKeyType =
    with lib.types;
    attrsOf (
      submodule (
        { name, ... }@masterKey:
        {
          options = {
            classifier = lib.mkOption {
              readOnly = true;
              type = lib.types.str;
              default = name;
            };
            username = lib.mkOption {
              type = lib.types.str;
            };
            fullname = lib.mkOption {
              type = lib.types.str;
            };
            email = lib.mkOption {
              type = lib.types.str;
            };
            key = lib.mkOption {
              type = masterKeyRegexType;
            };
            subKeys = lib.mkOption {
              default = { };
              type = subKeyType;
            };
          };
        }
      )
    );

in
{
  options.custom.gpg-keys = {
    masterKeys = lib.mkOption {
      default = { };
      type = masterKeyType;
    };
  };
}
