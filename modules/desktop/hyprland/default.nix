# Hyprland
{host, ...}: let
  isNvidiaCard =
    if host.name == "zeus"
    then false
    else false;
in {
  imports = [
    ./settings
    ./extra
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = isNvidiaCard;
  };
}
