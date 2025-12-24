# file: /etc/nixos/home/git.nix
{ config, pkgs, ... }:

let
gitUserName = "Your Name";
gitUserEmail = "your.email@example.com";
sshKeyPath = "${config.home.homeDirectory}/.ssh/id_ed25519";

setupGitSsh = pkgs.writeShellScriptBin "setup-git-ssh" ''
set -e

echo "🔧 Setting up Git SSH authentication..."

# Check for existing key
if [ -f "${sshKeyPath}" ]; then
echo "✅ SSH key already exists at ${sshKeyPath}"
echo ""
echo "📋 Your public key (add to GitHub/GitLab):"
echo "----------------------------------------"
cat "${sshKeyPath}.pub"
echo "----------------------------------------"
else
# Generate new key
echo "Generating new SSH key..."
${pkgs.openssh}/bin/ssh-keygen -t ed25519 -C "${gitUserEmail}" \
    -f "${sshKeyPath}" -N "" -q

    echo "✅ SSH key generated!"
    echo ""
    echo "📋 ADD THIS PUBLIC KEY TO:"
    echo "   GitHub:   https://github.com/settings/keys"
    echo "   GitLab:   https://gitlab.com/-/profile/keys"
    echo ""
    echo "Public key:"
    echo "----------------------------------------"
    cat "${sshKeyPath}.pub"
    echo "----------------------------------------"
    fi

# Simple test
    echo ""
    echo "🧪 Testing connection to GitHub..."
    if ${pkgs.openssh}/bin/ssh -T git@github.com 2>&1 | grep -q "authenticated"; then
    echo "✅ GitHub: Authentication successful!"
    else
    echo "⚠️  GitHub: Authentication needed"
    echo "   Add the public key above to your GitHub account"
    fi
    '';
    in
{
  programs.git.settings = {
    enable = true;

    userName = gitUserName;
    userEmail = gitUserEmail;

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = false;
      color.ui = true;
    };

  };

  home.packages = with pkgs; [
    git
      openssh
      setupGitSsh
  ];
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;  # Don't use old defaults

      matchBlocks = {
        "*" = {
          extraOptions = {
            AddKeysToAgent = "yes";
          };
          identityFile = sshKeyPath;
        };
      };
  };  
  programs.zsh.shellAliases = {
    git-s = "git status";
    git-co = "git checkout";
    git-br = "git branch";
    git-ci = "git commit";
    git-cam = "git commit -am";
    git-amend = "git commit --amend";
    git-unstage = "git reset HEAD --";
    git-last = "git log -1 HEAD";
    git-undo = "git reset --soft HEAD~1";
    git-wip = "git add -A && git commit -m 'WIP'";
    git-unwip = "git reset HEAD~1";
    git-lg = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    git-lol = "git log --graph --decorate --pretty=oneline --abbrev-commit";
    git-hist = "git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
    git-d = "git diff";
    git-dc = "git diff --cached";
    git-dw = "git diff --word-diff";
    git-pu = "git push";
    git-pl = "git pull";
    git-puf = "git push --force-with-lease";
  };
}
