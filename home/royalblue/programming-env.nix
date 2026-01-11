{ config, lib, pkgs, ... } :

{
  home.packages = with pkgs; [
    nodejs
      docker
      docker-compose
      gcc
  ];
}
