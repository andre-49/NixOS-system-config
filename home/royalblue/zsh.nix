# file: /etc/nixos/home/zsh.nix
{ config, pkgs, ... }:

let
  # Import Oh-My-Zsh from Nixpkgs
  ohMyZsh = pkgs.oh-my-zsh;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Shell aliases
    shellAliases = {
ff = "fastfetch";
      ls = "eza --icons --color=always --group-directories-first";
      ll = "eza -alF --icons --color=always --group-directories-first";
      la = "eza -a --icons --color=always --group-directories-first";
      l = "eza -F --icons --color=always --group-directories-first";
      "l." = "eza -a | egrep '^\.'";
      nixswitch = "sudo nixos-rebuild switch";
      nixtest = "sudo nixos-rebuild dry-build";
      nixbuild = "sudo nixos-rebuild build";
      nixgc = "sudo nix-collect-garbage -d";
      nixclean = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
      grep = "ripgrep --color=auto";
      ip = "ip --color=auto";
      df = "df -h";
      du = "du -h";
      free = "free -h";
    };

    # Environment variables
    envExtra = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
      export PAGER="less"
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="$HOME/.cargo/bin:$PATH"
      export PATH="$HOME/go/bin:$PATH"
    '';

    # Custom .zshrc additions
    initContent = ''
      # Manual Oh-My-Zsh setup
      export ZSH="${ohMyZsh}/share/oh-my-zsh"
      export ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
      export ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"
      
      # Source Oh-My-Zsh
      source "$ZSH/oh-my-zsh.sh"
      
      # Set theme to gnzh
      ZSH_THEME="gnzh"
      source "$ZSH/themes/$ZSH_THEME.zsh-theme"
      
      # Load your plugins
      plugins=(
        git           # Essential git aliases and functions
        sudo          # Press ESC twice to add sudo
        docker        # Docker aliases
        npm           # npm completion
        node          # node/npm helpers
        history       # Better history
        colored-man-pages  # Colored man pages
        copydir       # Copy directory path
        copyfile      # Copy file contents
        dirhistory    # Directory navigation
      )
      
      for plugin in "''${plugins[@]}"; do
        if [ -f "$ZSH/plugins/$plugin/$plugin.plugin.zsh" ]; then
          source "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
        fi
      done
      
      # Pywal colors for Zsh
      if [ -f "$HOME/.cache/wal/sequences" ]; then
        (cat "$HOME/.cache/wal/sequences" &)
      fi
      
      # mkcd function
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }

      # History settings
      HISTFILE="$HOME/.zsh_history"
      HISTSIZE=10000
      SAVEHIST=10000
      setopt HIST_IGNORE_ALL_DUPS  # Remove duplicate commands
      setopt HIST_SAVE_NO_DUPS     # Don't save duplicates
      setopt INC_APPEND_HISTORY    # Append to history immediately
      setopt SHARE_HISTORY         # Share history between sessions

      # Better cd
      setopt AUTO_CD               # Type directory name to cd
      setopt CORRECT               # Correct typos
      setopt CORRECT_ALL           # Correct all arguments

      # Keybindings (like bash)
      bindkey '^[[3~' delete-char          # Delete key
      bindkey '^[[1;5C' forward-word       # Ctrl+Right
      bindkey '^[[1;5D' backward-word      # Ctrl+Left
      bindkey '^H' backward-kill-word      # Ctrl+Backspace
      bindkey '^[[3;5~' kill-word          # Ctrl+Delete

      # Color support
      export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

      # FZF integration (if installed)
      if command -v fzf >/dev/null 2>&1; then
        source ${pkgs.fzf}/share/fzf/completion.zsh
        source ${pkgs.fzf}/share/fzf/key-bindings.zsh
        export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
      fi

      # Nix shell hook
      if [ -n "$IN_NIX_SHELL" ]; then
        echo "🔨 Nix shell active"
      fi
    '';

    # Profile extras (runs for login shells)
    profileExtra = ''
      # Print system info on login
      if [ -z "$TMUX" ] && [ -n "$SSH_CONNECTION" ]; then
        echo "Connected via SSH from $SSH_CLIENT"
      fi
    '';
    
    # REMOVED: zdotDir = "$HOME/.config/zsh";  # This option doesn't exist
  };
  
  # Install required packages
  home.packages = with pkgs; [
    oh-my-zsh  # Required for manual setup
    eza        # For your aliases
    ripgrep    # For grep alias
    fzf        # For FZF integration
  ];
}
