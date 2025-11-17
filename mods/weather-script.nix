{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "vdr";
      runtimeInputs = [ pkgs.curl ];
      text = ''
                         #?M = m/s wind     # removes the stupid twitter ad
        curl -s "wttr.in/''${1:-}?M&lang=sv" | head -n -1
      '';
    })
  ];
}
