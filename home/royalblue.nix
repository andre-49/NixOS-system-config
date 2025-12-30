{ config, lib, pkgs, ... }:

{
  home.stateVersion = "25.11"; 
  imports = [
    ./royalblue/git.nix
      ./royalblue/hyprland.nix
      ./programs/wallpaper.nix
      ./royalblue/kitty.nix
      ./royalblue/zsh.nix
      ./royalblue/theme.nix
      ./royalblue/waybar.nix
#      ./royalblue/fonts.nix
      ./royalblue/hyprlock.nix
  ];
  home.file.".config/wal".source = ./royalblue/wal;
  home.file.".config/wlogout".source = ./royalblue/wlogout;
}
