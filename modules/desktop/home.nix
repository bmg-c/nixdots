# Hyprland

{ pkgs, host, ...}:

let
  isNvidiaCard = if host.name == "zeus" then false else true;
  envVariables = if host.name == "zeus" then ''
env = XCURSOR_SIZE,24
env = WLR_NO_HARDWARE_CURSORS,1
  '' else ''
env = XCURSOR_SIZE,24
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
  '';  
in {
  wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      enableNvidiaPatches = isNvidiaCard;
      extraConfig = ''
source=~/.config/hypr/mocha.conf
monitor=,preferred,auto,auto

exec-once = ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1
exec-once = ${pkgs.systemd}/bin/systemctl --user start kwallet.service

${envVariables}

xwayland {
    force_zero_scaling = true
}

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us,ru
    kb_variant = dvorak,
    kb_options = grp:caps_toggle

    repeat_rate = 38
    repeat_delay = 340

    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = -0.5 # -1.0 - 1.0, 0 means no modification.
    force_no_accel = 1
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more


    border_size = 3
    gaps_in = 5
    gaps_out = 20

    col.active_border=$pink
    col.inactive_border=$surface0

    col.group_border_active=$flamingo
    col.group_border=$surface0

    cursor_inactive_timeout = 5
    no_cursor_warps = false

    layout = dwindle
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10

    blur {
        enabled = true
        size = 3
        passes = 1
    }

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more new_is_master = true 
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = off
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
device:epic-mouse-v1 {
    sensitivity = -0.5
}

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod SHIFT, Return, exec, ${pkgs.kitty}/bin/kitty
bind = $mainMod SHIFT, C, killactive, 
bind = CTRL ALT, Backspace, exit, 
bind = $mainMod, V, togglefloating, 
bind = $mainMod, P, exec, ${pkgs.wofi}/bin/wofi --show drun
bind = $mainMod, R, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod SHIFT, F, fullscreen

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
      '';
  };

  home.file.".config/hypr/mocha.conf".text = ''
$rosewaterAlpha = f5e0dc
$flamingoAlpha  = f2cdcd
$pinkAlpha      = f5c2e7
$mauveAlpha     = cba6f7
$redAlpha       = f38ba8
$maroonAlpha    = eba0ac
$peachAlpha     = fab387
$yellowAlpha    = f9e2af
$greenAlpha     = a6e3a1
$tealAlpha      = 94e2d5
$skyAlpha       = 89dceb
$sapphireAlpha  = 74c7ec
$blueAlpha      = 89b4fa
$lavenderAlpha  = b4befe

$textAlpha      = cdd6f4
$subtext1Alpha  = bac2de
$subtext0Alpha  = a6adc8

$overlay2Alpha  = 9399b2
$overlay1Alpha  = 7f849c
$overlay0Alpha  = 6c7086

$surface2Alpha  = 585b70
$surface1Alpha  = 45475a
$surface0Alpha  = 313244

$baseAlpha      = 1e1e2e
$mantleAlpha    = 181825
$crustAlpha     = 11111b

$rosewater = 0xfff5e0dc
$flamingo  = 0xfff2cdcd
$pink      = 0xfff5c2e7
$mauve     = 0xffcba6f7
$red       = 0xfff38ba8
$maroon    = 0xffeba0ac
$peach     = 0xfffab387
$yellow    = 0xfff9e2af
$green     = 0xffa6e3a1
$teal      = 0xff94e2d5
$sky       = 0xff89dceb
$sapphire  = 0xff74c7ec
$blue      = 0xff89b4fa
$lavender  = 0xffb4befe

$text      = 0xffcdd6f4
$subtext1  = 0xffbac2de
$subtext0  = 0xffa6adc8

$overlay2  = 0xff9399b2
$overlay1  = 0xff7f849c
$overlay0  = 0xff6c7086

$surface2  = 0xff585b70
$surface1  = 0xff45475a
$surface0  = 0xff313244

$base      = 0xff1e1e2e
$mantle    = 0xff181825
$crust     = 0xff11111b
  '';
}
