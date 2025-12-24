# In your royalblue.nix
{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    settings = {
      font_family = "DejaVuSansM ";
      font_size = 16.0;
      background_opacity = 0.50;
      window_padding_width = 10.0;
      cursor_shape = "block";
      confirm_os_window_close = 0;
    };
    extraConfig = ''
      include ~/.cache/wal/colors-kitty.conf
      ''; 
  };
}
