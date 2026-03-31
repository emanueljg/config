{
  config,
  pkgs,
  lib,
  ...
}:
let
  settingsFormat = pkgs.formats.toml { };
  cfg = config.custom.programs.rustmission;
in
{
  options.custom.programs.rustmission = {
    enable = lib.mkEnableOption "rustmission";
    package = lib.mkPackageOption pkgs "rustmission" { };
    rpcUrl = lib.mkOption {
      type = lib.types.str;
    };
    settings = lib.mkOption {
      inherit (settingsFormat) type;
      default = { };
      example = "http://localhost:9091/transmission/rpc";
    };
    keymap = lib.mkOption {
      inherit (settingsFormat) type;
      default = { };
    };
    categories = lib.mkOption {
      inherit (settingsFormat) type;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    custom.wrap.wraps."rustmission" = {
      pkg = pkgs.rustmission;
      systemPackages = true;
      bins."rustmission".envs."XDG_CONFIG_HOME".paths =
        let
          tomlFormat = pkgs.formats.toml { };
        in
        {
          "rustmission/config.toml" = tomlFormat.generate "rustmission-config.toml" cfg.settings;
          "rustmission/keymap.toml" = tomlFormat.generate "rustmission-keymap.toml" cfg.keymap;
          "rustmission/categories.toml" = tomlFormat.generate "rustmission-categories.toml" cfg.categories;
        };
    };

    custom.programs.rustmission = lib.mkDefault {
      settings = {
        general = {
          # Whether to hide empty columns or not
          auto_hide = false;
          # Possible values: Red, Green, Blue, Yellow, Magenta, Cyan.
          # Use prefix "Light" for a brighter color.
          # It can also be a hex, e.g. "#3cb371"
          accent_color = "LightMagenta";

          # If enabled, shows various keybindings throughout the program at the cost of
          # a little bit cluttered interface.
          beginner_mode = true;

          # If enabled, hides table headers
          headers_hide = false;
        };

        connection = {
          url = cfg.rpcUrl; # REQUIRED!
          torrents_refresh = 5;
          stats_refresh = 5;
          free_space_refresh = 10;
          # If you need username and password to authenticate:
          # username = "CHANGE_ME"
          # password = "CHANGE_ME"
        };

        torrents_tab = {
          # Available fields:
          # Id, Name, SizeWhenDone, Progress, Eta, DownloadRate, UploadRate, DownloadDir,
          # Padding, UploadRatio, UploadedEver, AddedDate, ActivityDate, PeersConnected
          # SmallStatus, Category, CategoryIcon
          headers = [
            "Name"
            "SizeWhenDone"
            "Progress"
            "Eta"
            "DownloadRate"
            "UploadRate"
          ];

          # Default header to sort by:
          default_sort = "AddedDate";
          # Reverse the default sort?
          default_sort_reverse = true;

          # Whether to insert category icon into name as declared in categories.toml.
          # An alternative to inserting category's icon into torrent's name is adding a
          # CategoryIcon header into your headers.
          category_icon_insert_into_name = true;
        };

        search_tab = {
          # If you uncomment this, providers won't be automatically added in future
          # versions of Rustmission.
          # providers = ["Knaben", "Nyaa"]
        };

        icons = {
          # Ascii alternatives                # Defaults
          # upload = "↑"                      # ""
          # download = "↓"                    # ""
          # arrow_left = "←"                  # ""
          # arrow_right = "→"                 # ""
          # arrow_up = "↑"                    # ""
          # arrow_down = "↓"                  # ""
          # triangle_right = "▶"              # "▶"
          # triangle_down = "▼"               # "▼"
          # file = "∷"                        # ""
          # disk = "[D]"                      # "󰋊"
          # help = "[?]"                      # "󰘥"
          # success = "✔"                     # ""
          # failure = "✖"                     # ""
          # searching = "⟳"                   # ""
          # verifying = "⟳"                   # "󰑓"
          # loading = "⌛"                    # "󱥸"
          # pause = "‖"                       # "󰏤"
          # idle = "○"                        # "󱗼"
          # magnifying_glass = "[o]"          # ""
          # provider_disabled = "⛔"          # "󰪎"
          # provider_category_general = "[G]" # ""
          # provider_category_anime = "[A]"   # "󰎁"
          # sort_ascending = "↓"              # "󰒼"
          # sort_descending = "↑"             # "󰒽""
        };
      };
      keymap = {
        general.keybindings = [
          {
            on = "?";
            action = "ShowHelp";
            show_in_help = false;
          }
          {
            on = "F1";
            action = "ShowHelp";
            show_in_help = false;
          }

          {
            on = "q";
            action = "Quit";
          }
          {
            on = "Esc";
            action = "Close";
          }
          {
            on = "Enter";
            action = "Confirm";
          }
          {
            on = " ";
            action = "Select";
          }
          {
            on = "Tab";
            action = "SwitchFocus";
          }
          {
            on = "/";
            action = "Search";
          }
          {
            on = "o";
            action = "XdgOpen";
          }

          {
            on = "1";
            action = "SwitchToTorrents";
          }
          {
            on = "2";
            action = "SwitchToSearch";
          }

          {
            on = "Home";
            action = "GoToBeginning";
          }
          {
            on = "End";
            action = "GoToEnd";
          }
          {
            on = "PageUp";
            action = "ScrollPageUp";
            show_in_help = false;
          }
          {
            on = "PageDown";
            action = "ScrollPageDown";
            show_in_help = false;
          }

          {
            modifier = "Ctrl";
            on = "u";
            action = "ScrollPageUp";
          }
          {
            modifier = "Ctrl";
            on = "d";
            action = "ScrollPageDown";
          }

          # Arrows
          {
            on = "Left";
            action = "Left";
          }
          {
            on = "Right";
            action = "Right";
          }
          {
            on = "Up";
            action = "Up";
          }
          {
            on = "Down";
            action = "Down";
          }

          # Vi
          {
            on = "h";
            action = "Left";
          }
          {
            on = "l";
            action = "Right";
          }
          {
            on = "k";
            action = "Up";
          }
          {
            on = "j";
            action = "Down";
          }

          # Sorting
          {
            on = "H";
            action = "MoveToColumnLeft";
          }
          {
            on = "L";
            action = "MoveToColumnRight";
          }
        ];

        torrents_tab.keybindings = [
          {
            on = "a";
            action = "AddMagnet";
          }
          {
            on = "m";
            action = "MoveTorrent";
          }
          {
            on = "r";
            action = "Rename";
          }
          {
            on = "c";
            action = "ChangeCategory";
          }
          {
            on = "p";
            action = "Pause";
          }
          {
            on = "f";
            action = "ShowFiles";
          }
          {
            on = "s";
            action = "ShowStats";
          }

          {
            on = "d";
            action = "Delete";
          }
        ];

        search_tab.keybindings = [
          {
            on = "p";
            action = "ShowProvidersInfo";
          }
        ];
      };
    };
  };
}
