# file: programs/wallpaper.nix
{ config, pkgs, ... }:

let
wallpaper = "${config.home.homeDirectory}/Pictures/wallpaper/ninja.png";

setWallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
# Set wallpaper
${pkgs.swaybg}/bin/swaybg -i "${wallpaper}" -m fill &

# Generate pywal colors
${pkgs.pywal}/bin/wal -i "${wallpaper}" -n

# Cache colors for restoration
cp ~/.cache/wal/colors ~/.cache/wal/colors.last
'';
in
{
  home.packages = with pkgs; [ swaybg pywal setWallpaper ];

# Add to your shell profile for easy access
  programs.bash.shellAliases = {
    wallpaper = "set-wallpaper";
    wal-restore = "wal -R";
  };

  programs.zsh.shellAliases = {
    wallpaper = "set-wallpaper";
    wal-restore = "wal -R";
  };

# Auto-run on login
  wayland.windowManager.hyprland.settings.exec-once = [
    "${setWallpaper}/bin/set-wallpaper"
  ];
}
