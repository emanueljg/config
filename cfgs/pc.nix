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
    pavucontrol
    bluetooth
    greetd
    pipewire

    # general software
    firefox
    qutebrowser
    tor-browser
    weather-script

    # wayland
    uwsm
    river-classic
    waybar
    wmenu
    wl-clipboard
    wlock
    wayland-env
    wlr-randr
    fnott

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
