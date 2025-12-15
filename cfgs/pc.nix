{
  modules,
  sourceModules,
  configs,
  ...
}:
{

  imports = [
    configs.base
    sourceModules.disko
  ]
  ++ (with modules; [

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
    neomutt

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
  ]);
}
