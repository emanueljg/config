{
  modules,
  sourceModules,
  nixpkgs,
  ...
}:
{
  imports = [

    { _module.args = { inherit nixpkgs; }; }

    sourceModules.sops-nix

    {
      nix.nixPath = [
        # NOTE: this'll be nixos-unstable
        "nixpkgs=${nixpkgs}"
      ];
    }

  ]
  ++ (with modules; [
    hw.libinput
    hw.efi-grub
    wrap
    local
    keyboard
    enable-flakes
    garnix
    pkgs
    swedish-locale
    user
    sops
    bat
    nnn
    aliases
    access-tokens
    direnv
    keep-outputs-and-derivations
    starship
    git
    pass
    gpg
    helix
    zsh
    kitty
    themes
  ]);

}
