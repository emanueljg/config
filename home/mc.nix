{ inputs, pkgs, ... }: {
  home.packages = [
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
  ];
}
