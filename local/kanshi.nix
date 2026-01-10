{
  pkgs,
  lib,
  custom,
  ...
}:
{
  imports = [ custom.kanshi ];

  custom.services.kanshi =
    let
      # computer screen
      # eDP-1 = "BOE 0x0B38 0x0000000";
      eDP-1 = "eDP-1";

      # front
      DP-2-home = "ASUSTek COMPUTER INC VG258 L6LMQS111772";

      # left vertical
      DP-1-home = "ASUSTek COMPUTER INC VG258 L6LMQS112078";

      muse-dash = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/kx/wallhaven-kxpkoq.png";
        hash = "sha256-nzVK/UQDPw9xCjeLvQmXOLpmzILp/fcUwfE7NFVZiOg=";
      };
    in
    {
      enable = true;
      output = {
        ${eDP-1} = [
          "mode"
          "2560x1600@165.001999"
        ];

        ${DP-2-home} = [
          "mode"
          "1920x1080@164.917007"
        ];

        ${DP-1-home} = [
          "mode"
          "1920x1080@164.917007"
          "transform"
          270
        ];
      };

      profile = {
        "nomad" = {
          output."${eDP-1}" = [
            "scale"
            "1.5"
          ];
          exec = [
            "${lib.getExe pkgs.swaybg} --image ${muse-dash} -m center"
          ];
        };
        "home-desk".output = {
          ${DP-1-home} = [
            "position"
            "0,0"
          ];
          ${DP-2-home} = [
            "position"
            "1080,0"
          ];
          ${eDP-1} = [
            "position"
            "3000,0"
            "scale"
            2
          ];
        };
      };

    };
}
