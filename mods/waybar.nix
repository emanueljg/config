{ pkgs, ... }:
{
  local.programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (prev: {
      # river/tags: Allow river tags to be styled based on monitor focus
      # https://github.com/Alexays/Waybar/pull/3436#commits-pushed-85e1431
      src = pkgs.fetchFromGitHub {
        owner = "lilly-lizard";
        repo = "Waybar-fork";
        rev = "river-tags-monitor-focus";
        hash = "sha256-jATwXuP4VsRW/KwjK9XaN8B9AMhMTt9vh0kHPV0f6dQ=";
      };
    });
  };
}
