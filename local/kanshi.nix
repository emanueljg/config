{
  pkgs,
  lib,
  custom,
  config,
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

      kagari-screen = "China Star Optoelectronics Technology Co., Ltd MNG007DA6-2 0x00006006";

      work-screen = "Philips Consumer Electronics Company PHL34E1C5600 UK02515018381";

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
        ${kagari-screen} = [
          "mode"
          "2560x1600@240"
          "scale"
          "1.5"
        ];

        ${work-screen} = [
          "mode"
          "3440x1440@100"
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
        "work-nomad" = {
          output.${kagari-screen} = [ ];
          exec = [
            "${lib.getExe pkgs.swaybg} --output '${kagari-screen}' --image ${youmu}"
          ];
        };
        "work-office" = {
          output = {
            ${kagari-screen} = [
              "position"
              "0,0"
            ];
            ${work-screen} = [
              "position"
              "0,1440"
            ];
          };
          exec = [
            "${
              (builtins.head config.custom.services.kanshi.profile."work-nomad".exec)
            } --output '${work-screen}' --image ${
              pkgs.runCommand "lwa-1" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
                magick ${lwa-1} -crop 3440x1440+2000+300 +repage $out
              ''
            }"
          ];
        };
        # exec = [
        #   "${lib.getExe pkgs.swaybg} --image ${
        #   } -m center"
        # ];
        # };

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
