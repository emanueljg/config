{
  local,
  cfg,
  ...
}:
{
  imports = [
    cfg.base
  ]
  ++ (with local; [
    hostnames.void
    systems.x86_64-linux
    lan.void
    hw.nvidia
    hw.void

    sonarr
    # fuck this shit
    # invidious
    jellyfin
    navidrome
    rutorrent
    rtorrent

    nginx
    porkbun

    nixos-rebuild.void

    stateversions."22-11"

  ]);
}
