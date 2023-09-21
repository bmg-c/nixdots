{host, ...}: let
  programsWaybarSystemd =
    if host.desktop == "hyprland"
    then {
      enable = true;
      target = "hyprland-session.target";
    }
    else {};
in {
  imports = [
    ./style.nix
    ./settings.nix
    ./extra
  ];
  programs.waybar = {
    enable = true;
    systemd = programsWaybarSystemd;
  };
}
