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
    add-headphones-script

    # general software
    firefox
    qutebrowser
    tor-browser

    # wayland
    hyprland
    greetd
    swaylock
    pipewire
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
  ]);
}
