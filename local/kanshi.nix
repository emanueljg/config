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
      eDP-2 = "eDP-2";

      # front
      DP-2-home = "ASUSTek COMPUTER INC VG258 L6LMQS111772";

      # left vertical
      DP-1-home = "ASUSTek COMPUTER INC VG258 L6LMQS112078";

      lwa-1 = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/kw/wallhaven-kw88q1.jpg";
        hash = "sha256-fHBPV67wBhdNHz9ep5AGy/2MRSzG7ib4MME9x+JHRy0=";
        # hash = "sha256-nzVK/UQDPw9xCjeLvQmXOLpmzILp/fcUwfE7NFVZiOg=";
      };
      youmu = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/4d/wallhaven-4dm9ql.jpg";
        hash = "sha256-wwnRsPAbSEYdL5YVH5/P74GKFP91+iY/CW/eqeE8fus=";
        # hash = "sha256-k0ghrYhzSAPQ+ewaLc2EGL9UysBB3xOiT4qIIOolKl8=";
      };
      brs-1 = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/43/wallhaven-43yrgy.jpg";
        hash = "sha256-YiJVIS/PNfoC3m+/w74XLs2f6knU3ziFMEUfemsiCR4=";
      };
    in
    {
      enable = true;
      output = {
        ${eDP-1} = [
          "mode"
          "2560x1600@165.001999"
        ];

        ${eDP-2} = [
          "mode"
          "2560x1600@240"
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
            "${lib.getExe pkgs.swaybg} --image ${
              pkgs.runCommand "lwa-1" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
                magick ${lwa-1} +repage -crop 2560x1600+0+0 +repage $out
              ''
            } -m center"
          ];
        };

        "work-nomad" = {
          output."${eDP-2}" = [
            "scale"
            "1.5"
          ];
          exec = [
            "${lib.getExe pkgs.swaybg} --image ${youmu}"

          ];
          # exec = [
          #   "${lib.getExe pkgs.swaybg} --image ${
          #     pkgs.runCommand "lwa-1" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
          #       magick ${lwa-1} -crop 2560x1600+2500+400 +repage $out
          #     ''
          #   } -m center"
          # ];
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
