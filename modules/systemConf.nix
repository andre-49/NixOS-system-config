{config, lib, pkgs, ...}:

{
# Polkit
security.polkit.enable = true;
#  boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
    extraInstallCommands = ''
# Check if Arch EFI is already mounted somewhere
      if ${pkgs.coreutils}/bin/grep -q '/dev/sda1' /proc/mounts; then
# Find where it's mounted
        MOUNT_POINT=$(${pkgs.coreutils}/bin/grep '/dev/sda1' /proc/mounts | ${pkgs.coreutils}/bin/cut -d' ' -f2)
          ${pkgs.coreutils}/bin/mkdir -p "$MOUNT_POINT/EFI/arch"
          ${pkgs.coreutils}/bin/cp -rf /boot/efi/EFI/nixos/* "$MOUNT_POINT/EFI/arch/"
                                                             fi
                                                             '';
                                                             };
                                                             boot.loader.systemd-boot.configurationLimit = 3;
                                                             boot.loader.efi.efiSysMountPoint = "/boot/";
                                                             boot.loader.efi.canTouchEfiVariables = true;
#  boot.loader.systemd-boot.extraEntries = {
#    "arch.conf" = ''
#      title   Arch-linux
#      linux   /vmlinuz-linux
#      initrd  /initramfs-linux.img
#      options root=UUID=573e0afb-7c4e-4325-8930-89a1c2438802 rw
#      '';
#  };
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
nix.settings.experimental-features = [ "nix-command" "flakes" ];
virtualisation.docker = {
enable = true;
enableOnBoot = true;
};
}
