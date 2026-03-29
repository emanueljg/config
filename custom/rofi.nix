{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.rofi;

  mkValueString =
    value:
    if lib.isBool value then
      if value then "true" else "false"
    else if lib.isInt value then
      toString value
    else if (value._type or "") == "literal" then
      value.value
    else if lib.isString value then
      ''"${value}"''
    else if lib.isList value then
      "[ ${lib.strings.concatStringsSep "," (map mkValueString value)} ]"
    else
      abort "Unhandled value type ${builtins.typeOf value}";

  mkKeyValue =
    {
      sep ? ": ",
      end ? ";",
    }:
    name: value: "${name}${sep}${mkValueString value}${end}";

  mkRasiSection =
    name: value:
    if lib.isAttrs value then
      let
        toRasiKeyValue = lib.generators.toKeyValue { mkKeyValue = mkKeyValue { }; };
        # Remove null values so the resulting config does not have empty lines
        configStr = toRasiKeyValue (lib.filterAttrs (_: v: v != null) value);
      in
      ''
        ${name} {
        ${configStr}}
      ''
    else
      (mkKeyValue {
        sep = " ";
        end = "";
      } name value)
      + "\n";

  toRasi =
    attrs:
    lib.concatStringsSep "\n" (
      lib.concatMap (lib.mapAttrsToList mkRasiSection) [
        (lib.filterAttrs (n: _: n == "@theme") attrs)
        (lib.filterAttrs (n: _: n == "@import") attrs)
        (removeAttrs attrs [
          "@theme"
          "@import"
        ])
      ]
    );

  primitive =
    with lib.types;
    (oneOf [
      str
      int
      bool
      rasiLiteral
    ]);

  # Either a `section { foo: "bar"; }` or a `@import/@theme "some-text"`
  configType = with lib.types; (either (attrsOf (either primitive (listOf primitive))) str);

  rasiLiteral =
    lib.types.submodule {
      options = {
        _type = lib.mkOption {
          type = lib.types.enum [ "literal" ];
          internal = true;
        };

        value = lib.mkOption {
          type = lib.types.str;
          internal = true;
        };
      };
    }
    // {
      description = "Rasi literal string";
    };
in
{

  options.custom.programs.rofi = {
    enable = lib.mkEnableOption "Rofi: A window switcher, application launcher and dmenu replacement";

    package = lib.mkPackageOption pkgs "rofi" {
      example = "pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; }";
    };

    settings = lib.mkOption {
      default = { };
      example = lib.literalExpression ''
        {
          kb-primary-paste = "Control+V,Shift+Insert";
          kb-secondary-paste = "Control+v,Insert";
        }
      '';
      type = configType;
    };

  };

  config = lib.mkIf cfg.enable {
    lib.formats.rasi.mkLiteral = value: {
      _type = "literal";
      inherit value;
    };

    custom.wrap.wraps."rofi" = {
      pkg = cfg.package;
      systemPackages = true;
      bins."rofi".flags = {
        "-config".path = toRasi cfg.settings;
      };
    };
  };
}
