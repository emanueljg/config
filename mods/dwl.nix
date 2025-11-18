{
  pkgs,
  config,
  lib,
  ...
}:
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "run-bar" ''
      someblocks &
      somebar
    '')
  ];
  local.greetd.tuigreet.cmd = "dwl -s run-bar";

  programs.dwl = {
    enable = true;
    package = pkgs.dwl.overrideAttrs (prev: {
      src = pkgs.fetchFromGitHub {
        owner = "emanueljg";
        repo = "dwl";
        rev = "config";
        hash = "sha256-6btrwwi1kvIUm8lXCnlgWq7PvuV16gGkyvx2z3n5PPE=";
        # hash = "sha256-eIMLe4OMMcjuaY6AuGKEnW2rwG+lukeucpeE4yuglFQ=";
        # hash = "sha256-czclcNXtvtqgIFP9seThAfJDRdXMguDjG6TFX5Sj164=";
        # hash = "sha256-1emxFQKgdu9jkkKvW1VPQdM9PhKKc1vunxLKS4UbWoU=";
        # hash = "sha256-NKNWeGN+Z/tWQ/WCnEdXFwimLNRdqKLoGNCTQnoUUlI=";
        # hash = "sha256-NKNWeGN+Z/tWQ/WCnEdXFwimLNRdqKLoGNCTQnoUUlI=";
      };
      postPatch =
        let
          theme = config.local.themes."Everforest Dark Medium";
          focus = lib.removePrefix "#" theme.fg.statusline1;
        in
        (prev.postPatch or "")
        + ''
          substituteInPlace 'config.def.h' \
            --replace-fail \
              'static const float focuscolor[]            = COLOR(0x005577ff);' \
              'static const float focuscolor[]            = COLOR(0x${focus}ff);'
              
        '';
    });
  };
}
