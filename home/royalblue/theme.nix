# /etc/nixos/home/theme.nix
{ config, pkgs, ... }:

{
  # Cursor theme
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # GTK theme
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    
    # Tela Purple icon theme
    iconTheme = {
      name = "Flat-Remix-Green-Dark";
      package = pkgs.flat-remix-icon-theme;
    };
    
    font = {
      name = "Sans";
      size = 11;
    };
  };

  # QT theme
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # Environment variables
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "adwaita";
    GTK_ICON_THEME = "Flat-Remix-Green-Dark";
  };
}
