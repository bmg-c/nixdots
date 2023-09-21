{host, ...}: let
  windowRules =
    if host.name == "zeus"
    then ''''
    else '''';
in {
  wayland.windowManager.hyprland.extraConfig = ''
    windowrule = workspace 2 silent, ^(brave-browser)$
    windowrule = workspace 5 silent, ^(org.telegram.desktop)$
    windowrule = workspace 4 silent, ^(YouTube Music)$
    windowrule = float, ^(pavucontrol)$
    windowrule = float, ^(brave)$
    ${windowRules}
  '';
}
