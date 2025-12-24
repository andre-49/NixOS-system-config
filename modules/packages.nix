{config, lib, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
# Essentials
    vim 
      wget
      curl
      git
      htop
      eza
      ripgrep
      bat
      fzf
      fd
      zsh
      oh-my-zsh
      neovim
      yazi
      lxqt.lxqt-policykit
      wl-clipboard
      keyd


# Secondary
      kitty
      firefox
      nwg-look
      btop
      brightnessctl
      obsidian
      feh
      nemo
      nicotine-plus
      qbittorrent
      strawberry
      vscode

# UI related
      waybar
      pywal
      pywalfox-native
      swaybg
      wlogout
      rofi
      fastfetch
      grim
      slurp
      swappy
      imagemagick
      ];
}
