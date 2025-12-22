{ config, lib, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true; # bootloader
    boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Bill Evans"; # Define your hostname.
    networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Africa/Kigali";
# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

# Desktop Environment
  displayManager.sddm.enable = true;
  displayManager.sddm.wayland.enable = true;
  programs.hyprland.enable = true;
  programs.zsh.enable = true;

# Enable CUPS to print documents.
# services.printing.enable = true;

# Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "layer(control)";
          };
          otherlayer = {};
        };
        extraConfig = ''
 Any extra config goes here, like like whaat you might copy/past
          '';
      };
    };
  };

  users.users = {
    user1 = {
      name = "Tadd's Delight";
      group = "A Jazz Standard";
      isNormalUser = true;
      description = "The main user";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      kitty
      firefox
      git
      curl
      waybar
      nwg-look
      btop
      fastfetch
      keymapper
      rofi
      neovim
      wlogout
      brightnessctl
      obsidian
      pywal
      pywalfox-native
      eza
      swaybg
      zsh
      ];


# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you dlt config.nix
 system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Do not change
}

