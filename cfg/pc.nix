{
  local,
  sourceModules,
  cfg,
  ...
}:
{

  imports = [
    cfg.base
    sourceModules.disko
  ]
  ++ (with local; [

    # core
    networkmanager
    wiremix
    bluetooth
    greetd
    pipewire

    # general software
    firefox
    qutebrowser
    tor-browser
    weather-script
    aerc
    isync

    # wayland
    uwsm
    runapp
    river-classic
    waybar
    wmenu
    wl-clipboard
    wlock
    wayland-env
    wlr-randr
    mako
    kanshi
    lsix

    # multimedia
    mpv
    ffmpeg
    ani-cli
    yt-dlp
    qbittorrent
    pipe-viewer
    zathura

    # customization
    rice.darker
    xdg
    cursor
    fontconfig
    add-headphones-script

    udisks2-and-udiskie
  ]);
}
