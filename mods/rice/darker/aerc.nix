{ config, lib, ... }:
let
  theme = config.local.themes."Everforest Dark Medium";
in
{
  local.aerc.aercSettings.ui.styleset-name = "everforest";
  local.aerc.stylesets."everforest" = ''
    *.default=true
    *.normal=true
      
    *.selected.bg = ${theme.fg.statusline1}
    *.selected.fg = ${theme.bg.bg0}

    *.selected.bold = true
    statusline_*.dim = true
    *warning.dim = false
    *warning.bold = true
    *warning.fg = 11
    *success.dim = false
    *success.bold = true
    *success.fg = 10
    *error.dim = false
    *error.bold = true
    *error.fg = 9
    border.bg = 12
    border.fg = 15
    title.bg = 12
    title.fg = 15
    title.bold = true
    header.fg = 4
    header.bold = true
    msglist_unread.bold = true
    msglist_deleted.dim = true
    msglist_marked.bg = 6
    msglist_marked.fg = 15
    msglist_pill.bg = 12
    msglist_pill.fg = 15
    part_mimetype.fg = 12
    selector_chooser.bold = true
    selector_focused.bold = true
    selector_focused.bg = 12
    selector_focused.fg = 15
    completion_*.bg = 8
    completion_pill.bg = 12
    completion_default.fg = 15
    completion_description.fg = 15
    completion_description.dim = true

    [viewer]
    url.underline = true
    url.fg = 3
    header.bold = true
    header.fg = 4
    signature.dim = true
    signature.fg = 4
    diff_meta.bold = true
    diff_chunk.fg = 6
    diff_chunk_func.fg = 6
    diff_chunk_func.dim = true
    diff_add.fg = 2
    diff_del.fg = 1
    quote_1.fg = 6
    quote_2.fg = 4
    quote_3.fg = 6
    quote_3.dim = true
    quote_4.fg = 4
    quote_4.dim = true
    quote_x.fg = 5
    quote_x.dim = true
  '';
}
