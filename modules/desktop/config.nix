# Hyprland

{ pkgs, host, ...}:

{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  environment.systemPackages = with pkgs; [
    bemenu
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
  ];
}
