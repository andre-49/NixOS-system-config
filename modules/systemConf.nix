{config, lib, pkgs, ...}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
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
  programs.dconf.enable = true;

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
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = ''--delete-older-than "3" --delete-older-than 14d'';
    };
    settings.auto-optimise-store = true;
  };
}
