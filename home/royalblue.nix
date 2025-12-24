{ config, lib, pkgs, ... }:

{
  home.stateVersion = "25.11"; 
  imports = [
    ./royalblue/git.nix
      ./royalblue/hyprland.nix
  ];
}
