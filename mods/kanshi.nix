{
  imports = [ ./local/kanshi.nix ];

  local.kanshi =
    let
      # computer screen
      eDP-1 = "BOE 0x0B38 0x0000000";

      # front
      DP-2-home = "ASUSTek COMPUTER INC VG258 L6LMQS111772";

      # left vertical
      DP-1-home = "ASUSTek COMPUTER INC VG258 L6LMQS112078";
    in
    {
      enable = true;
      outputs = {
        ${eDP-1} = [
          "mode"
          "2560x1600@165.001999"
          "scale"
          2
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

      profiles = {
        "nomad".outputs."${eDP-1}" = [ ];
        "home-desk".outputs = {
          ${DP-1-home} = [ ];
          ${DP-2-home} = [
            "position"
            "1080,0"
          ];
          ${eDP-1} = [
            "position"
            "3000,0"
          ];
        };
      };

    };
}
