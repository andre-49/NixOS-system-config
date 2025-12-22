{ config, lib, pkgs, ... }:

let
secretsDir = /etc/nixos/secrets;

readPasswdHash = username:
let
file = "${secretsDir}/${username}-passwd-hash";
in
if builtins.pathExists file then
builtins.readFile file
else
throw "Password file ${file} not found for user ${username}";
in
{
  users.users = {
    royalblue = {
      description = "Blues for a Hip King";
      group = "royalblue";
      isNormalUser = true;
      extraGroups = [
        "wheel"
          "networkmanager"
      ];
      uid = 1001;
      createHome = true;
      home = "/home/royalblue";
      shell = pkgs.zsh;
      hashedPassword = readPasswdHash "royalblue";
    };
    root.hashedPassword = readPasswdHash "root";
  };
}
