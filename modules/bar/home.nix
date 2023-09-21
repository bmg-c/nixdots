{host, ...}: let
  bar =
    if host.bar == "waybar"
    then [./waybar]
    else [];
in {
  imports = bar;
}
