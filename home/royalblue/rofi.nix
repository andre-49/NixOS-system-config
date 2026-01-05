{ config, pkgs, ... }:

{
  home.file.".config/rofi/config.rasi".text = ''
    configuration {
font: "JetBrainsMono Nerd Font Medium 24";
      show-icons: true;

      drun {
        display-name: " ";
        icon-theme: "breeze-dark";
        display-format: "{icon} {name}";
      }

      run {
        display-name: "";
      }

      window {
        display-name: "";
      }

      dmenu {
        display-name: "󰸌";
      }

terminal: "kitty";
          hover-select: true;
          me-select-entry: "";
          me-accept-entry: [ MousePrimary, MouseSecondary, MouseDPrimary ];
    }

  @import "./color_wal.rasi"

    * {
margin: 0;
padding: 0;
spacing: 0;
         background-color: transparent;
    }

  window {
transparency: "real";
              background-color: none;
border: none;
        border-radius: 8px;
        border-color: @border-color;
padding: 4px;
fullscreen: true;
margin: 10%;
  }

  mainbox {
padding: 15% 15%;
children: [inputbar, listview];
  }

  inputbar {
    border-radius: 8px;
    background-color: transparent;
children: [prompt, entry];
  }

  entry {
    background-color: inherit;
margin: 16px;
color: @foreground-color;
  }

  prompt {
    background-color: inherit;
padding: 16px 16px 16px 30px;
color: @foreground-color;
  }

  listview {
lines: 5;
margin: 8px 0;
        show-icons: true;
border: none;
  }

  element {
margin: 0;
padding: 0;
spacing: 0;
         border-radius: 0px;
children: [element-icon, element-text];
  }

  element-text, element-icon {
    text-color: @foreground-color;
    background-color: @unspoken;
padding: 10px 0 10px 20px;
  }

  element-text selected, element-icon selected {
    text-color: @selected-foreground-color;
    background-color: @selected-background-color;
  }

  scrollbar {
    handle-color: @border-color;
  }
  '';
}
