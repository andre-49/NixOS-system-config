{config, lib, pkgs, ...}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "BillEvans";
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Africa/Kigali";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [ material-cursors ];
  environment.sessionVariables = {
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "material-cursors";

  };
  programs.dconf.enable = true;

# Optional: Set GTK cursor theme too
  environment.variables = {
# For GTK3/GTK4 apps
    GTK_THEME = "Adwaita:dark";

# Force Qt apps to use GTK theme (for consistency)
    QT_QPA_PLATFORMTHEME = "gtk3";
  };
  programs.zsh.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "layer(control)";
            compose = "leftcontrol";
          };
          control = {
            space = "C-tab";
          };
          otherlayer = {};
        };
        extraConfig = ''
          Any extra config goes here
          '';
      };
    };
  };
}
