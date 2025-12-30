# file: /etc/nixos/home/waybar.nix
{ config, pkgs, ... }:

let
  waybarConfig = import ./waybar/config.nix { inherit pkgs; };
in
{
  programs.waybar = {
    enable = true;
    settings = waybarConfig.settings;
    style = waybarConfig.style;
  };
  
  home.packages = with pkgs; [
    blueman
    pavucontrol
  ];
}
