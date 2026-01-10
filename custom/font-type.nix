{ lib, ... }:
{
  options.custom.lib.fontType = lib.mkOption {
    readOnly = true;
    type = lib.types.anything;
    default = lib.types.submodule {
      options = {
        package = lib.mkOption {
          type = with lib.types; nullOr package;
          default = null;
          example = lib.literalExpression "pkgs.dejavu_fonts";
          description = ''
            Package providing the font. This package will be installed
            to your profile. If `null` then the font
            is assumed to already be available in your profile.
          '';
        };

        name = lib.mkOption {
          type = lib.types.str;
          example = "DejaVu Sans";
          description = ''
            The family name of the font within the package.
          '';
        };

        size = lib.mkOption {
          type = with lib.types; nullOr number;
          default = null;
          example = "8";
          description = ''
            The size of the font.
          '';
        };
      };
    };
  };
}
