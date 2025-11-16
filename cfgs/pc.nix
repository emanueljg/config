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
    hw.bluetooth
    greetd
    pipewire

    # general software
    firefox
    qutebrowser
    tor-browser

    # wayland
    hyprland
    swaylock
    wl-clipboard
    wofi
    waybar

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
