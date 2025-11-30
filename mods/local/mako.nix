{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.local.mako;
in
{
  options.local.mako = {
    enable = lib.mkEnableOption "mako";
    package = lib.mkPackageOption pkgs "mako" { };
    settings = lib.mkOption {
      type = with lib.types; attrsOf anything;
      default = { };
    };
  };
  config = lib.mkIf cfg.enable {
    local.wrap.wraps."mako" = {
      pkg = cfg.package;
      systemPackages = true;
      bins."mako".flags."--config".path = lib.mkIf (cfg.settings != { }) (
        lib.concatMapAttrsStringSep "\n" (n: v: "${n}=${builtins.toString v}") cfg.settings
      );
      postWrap = ''
        mv $out/lib/systemd/user/mako.service \
           $out/lib/systemd/user/mako.service.upstream
        substitute $out/lib/systemd/user/mako.service.upstream \
                   $out/lib/systemd/user/mako.service \
          --replace-fail 'ExecStart=${lib.getExe cfg.package}' \
                         "ExecStart=$out/bin/mako"
        rm $out/lib/systemd/user/mako.service.upstream
      '';
    };
  };
}
