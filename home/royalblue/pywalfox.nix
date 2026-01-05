{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pywalfox-native
  ];
  
  # Auto-start pywalfox daemon
  systemd.user.services.pywalfox = {
    Unit = {
      Description = "Pywalfox daemon";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.pywalfox-native}/bin/pywalfox start";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
