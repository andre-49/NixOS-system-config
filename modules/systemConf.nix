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
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;  # Turn on Bluetooth at boot
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
  };

# Optional: Bluetooth audio support
  services.blueman.enable = true;
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
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        dejavu_fonts
        ubuntu-classic
    ];

    fontconfig.enable = true;
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
