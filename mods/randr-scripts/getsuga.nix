{ pkgs, ... }:
{
  environment.systemPackages = [
    (
      (pkgs.writeShellApplication {
        name = "randr-home";
        runtimeInputs = [ pkgs.wlr-randr ];
        text = ''
          wlr-randr \
            --output 'DP-1' \
            --mode '1920x1080@164.917007' \
            --transform '270'

          wlr-randr \
            --output 'DP-2' \
            --mode '1920x1080@164.917007' \
            --right-of 'DP-1'

          wlr-randr \
            --output 'eDP-1' \
            --mode '2560x1600@165.001999' \
            --right-of 'DP-2'
        '';
      })
    )
  ];
}
