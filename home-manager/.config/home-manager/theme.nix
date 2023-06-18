# vim: shiftwidth=2
{ config, pkgs, ... }:

let
  font_conf = {
    name = "Source Code Pro";
    size = 10;
    # TODO: font package
  };

  gtk_theme = {
    name = "Catppuccin-Macchiato-Standard-Mauve-Dark";
    package = pkgs.catppuccin-gtk.override {
      accents = [ "mauve" ];
      variant = "macchiato";
    };
  };

  cursor_theme = {
    name = "Catppuccin-Macchiato-Mauve-Cursors";
    size = 32;
    package = pkgs.catppuccin-cursors.macchiatoMauve;
  };

  icon_theme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
    # package = pkgs.catppuccin-papirus-folders.override {
    #   accent = "mauve";
    #   flavor = "macchiato";
    # };
  };

  qt_theme = {
    name = "Catppuccin-Macchiato-Mauve";
    package = pkgs.catppuccin-kvantum.override {
      accent = "Mauve";
      variant = "Macchiato";
    };
  };
in
{
  # Gtk {{{
  gtk = {
    enable = true;

    theme       = { inherit (gtk_theme)    name package; };
    cursorTheme = { inherit (cursor_theme) name size package; };
    font        = { inherit (font_conf)    name size; };
    iconTheme   = { inherit (icon_theme)   name package; };
  };
  # }}}

  # QT / Kvantum {{{
  qt = {
    enable = true;
    style.name = "kvantum";
  };

  home.file = {
    ".config/Kvantum/${qt_theme.name}".source = "${qt_theme.package}/share/Kvantum/${qt_theme.name}";

    ".config/Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=${qt_theme.name}
      '';
  };
  # }}}

  # Dconf theme {{{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme    = gtk_theme.name;
      icon-theme   = icon_theme.name;
      cursor-theme = cursor_theme.name;
      cursor-size  = cursor_theme.size;
      font-name    = "${font_conf.name} ${toString font_conf.size}";
      color-scheme = "prefer-dark";
    };
  };
  # }}}

  # Default and sway cursor {{{
  home.file = {
    ".local/share/icons/default/index.theme".text = ''
        [Icon Theme]
        Inherits=${cursor_theme.name}
      '';

    ".config/sway/config.d/cursor".text = ''
        seat * xcursor_theme ${cursor_theme.name} ${toString cursor_theme.size}
      '';
  };
  # }}}

  # Make theme and icon files available for user {{{
  home.file = {
    ".local/share/themes/${gtk_theme.name}".source   = "${gtk_theme.package}/share/themes/${gtk_theme.name}";
    ".local/share/icons/${cursor_theme.name}".source = "${cursor_theme.package}/share/icons/${cursor_theme.name}";
    ".local/share/icons/${icon_theme.name}".source   = "${icon_theme.package}/share/icons/${icon_theme.name}";
  };
  # }}}
}
