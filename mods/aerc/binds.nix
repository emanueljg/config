{
  local.aerc.bindsSettings = {
    globalSection = {
      Q = ":quit<Enter>";
      J = ":prev-tab<Enter>";
      K = ":next-tab<Enter>";
    };
    sections = {
      messages = {
        "<C-j>" = ":next-folder<Enter>";
        "<C-k>" = ":prev-folder<Enter>";

        j = ":next-message<Enter>";
        k = ":prev-message<Enter>";
        "<space>" = ":view-message<Enter>";

        n = ":compose<Enter>";

        d = ":move Papperskorgen<Enter>";

        "<tab>" = ":toggle-sidebar<Enter>";
      };

      view = {
        q = ":close<Enter>";
        "<space>" = ":next-part<Enter>";
        o = ":open<Enter>";
      };
      compose = {
        q = ":abort<Enter>";
      };
    };

  };
}
