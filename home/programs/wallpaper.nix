# file: programs/wallpaper.nix
{ config, pkgs, ... }:

let
wallpaper = "${config.home.homeDirectory}/Pictures/wallpaper/ninja.png";

rofiTheme = pkgs.writeShellScriptBin "rofiTheme" ''
# Rofi color extraction
#------------------------
# Path to pywal colors
COLORS_FILE="$HOME/.cache/wal/colors"

# Output Rasi file
RASI_FILE="$HOME/.config/rofi/color_wal.rasi"

# Check if pywal colors file exists
if [ ! -f "$COLORS_FILE" ]; then
    echo "Pywal colors file not found at $COLORS_FILE."
    exit 1
fi

# Section for setting colors on rofi
# Read colors from pywal colors file
readarray -t COLORS < "$COLORS_FILE"

# Start writing the rasi file
cat <<EOL > "$RASI_FILE"
* {
    unspoken: ''${COLORS[0]};
    foreground-color: ''${COLORS[7]};
    selected-background-color: ''${COLORS[1]};
    selected-foreground-color: ''${COLORS[15]};
    border-color: ''${COLORS[2]};
}
EOL

echo "Rasi file created at $RASI_FILE."
'';

setWallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
# Set wallpaper
${pkgs.swaybg}/bin/swaybg -i "${wallpaper}" -m fill &

# Generate pywal colors
${pkgs.pywal}/bin/wal -i "${wallpaper}" -n

# Cache colors for restoration
cp ~/.cache/wal/colors ~/.cache/wal/colors.last
'';

startupScript = pkgs.writeShellScriptBin "startup-wallpaper" ''
  ${setWallpaper}/bin/set-wallpaper
  # Small delay to ensure wal finishes
  sleep 0.5
  ${rofiTheme}/bin/rofiTheme
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
    "${startupScript}/bin/startup-wallpaper"];
}
