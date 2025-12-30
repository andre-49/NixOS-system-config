# file: /etc/nixos/home/waybar/config.nix
{ pkgs }:

let
  # Read CSS from file
  cssFile = ./style.css;
  filteredCss = builtins.readFile cssFile;
  
  # Main bar configuration (same as before)
  mainBar = {
    position = "bottom";
    height = 30;
    spacing = 2;
    
    "modules-left" = [ "hyprland/workspaces" ];
    "modules-center" = [ "custom/archlogo" ];
    "modules-right" = [ "bluetooth" "group/hardware" "clock" ];
    
    "hyprland/workspaces" = {
      format = "{icon}";
      "format-icons" = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "0";
      };
    };
    
    "custom/archlogo" = {
      format = "{} ";
      "return-type" = "json";
    };
    
    "group/hardware" = {
      orientation = "inherit";
      modules = [ "pulseaudio" "network" "battery" ];
    };
    
    battery = {
      states = {
        good = 75;
        warning = 35;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      "format-full" = "{icon}  {capacity}%";
      "format-charging" = "  {capacity}%";
      "format-plugged" = " {capacity}%";
      "format-alt" = "{time} {icon}";
      "restart-interval" = 2;
      "format-icons" = [ "" "" "" "" "" ];
    };
    
    network = {
      "format-wifi" = "   {signalStrength}%";
      "format-ethernet" = "󱘖";
      "tooltip-format" = "   {ifname} via {gwaddr}";
      "format-linked" = "  {ifname} (No IP)";
      "format-disconnected" = " ⚠  Disconnected";
      "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    };
    
    clock = {
      "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      "format-alt" = "{:%Y-%m-%d}";
    };
    
    pulseaudio = {
      "scroll-step" = 4;
      format = "{icon}  {volume}%";
      "format-bluetooth" = "{icon} {volume}%";
      "format-bluetooth-muted" = "  {icon} {format_source}";
      "format-muted" = "󰝟 ";
      "format-source" = " {volume}%";
      "format-source-muted" = "";
      "format-icons" = {
        headphone = " ";
        "hands-free" = " ";
        headset = " ";
        phone = " ";
        portable = " ";
        car = " ";
        default = [ " " " " " " ];
      };
      "on-click" = "pavucontrol";
    };
    
    bluetooth = {
      format = "";
      "format-disabled" = "";
      "format-no-controller" = "";
      interval = 30;
      "on-click" = "blueman-manager";
    };
  };
in
{
  settings.mainBar = mainBar;
  style = filteredCss;
}
