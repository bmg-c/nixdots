{...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    # Wayland/Hyprland environment varibles
    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE,wayland
    env = XDG_SESSION_DESKTOP,Hyprland
    env = QT_AUTO_SCREEN_SCALE_FACTOR,1
    env = QT_QPA_PLATFORM,wayland;xcb
    env = GDK_BACKEND,wayland,x11
    env = SDL_VIDEODRIVER,wayland
    env = CLUTTER_BACKEND,wayland
  '';
}
