# Hyprland
{host, ...}: let
  desktop =
    if host.desktop == "hyprland"
    then [./hyprland]
    else [];
in {
  imports = desktop;
}
