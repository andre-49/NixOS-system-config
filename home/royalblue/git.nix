{config, lib, pkgs, ...}:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "andre-49";
      email = "andy49miguel@gmail.com";
    };
  };
}
