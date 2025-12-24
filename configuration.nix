{ config, lib, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
      ./modules/systemConf.nix
      ./modules/packages.nix
      ./modules/users.nix
      <home-manager/nixos>
    ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.royalblue = import ./home/royalblue.nix;
  };

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you dlt config.nix
  system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Do not change
}

