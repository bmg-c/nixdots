# Hyprland

{ pkgs, host, ...}:

let
  swww-change = pkgs.writeShellScriptBin "swww-change" ''
#!/bin/sh
re="^[0-9]+$"

SOURCE_FOLDER=/home/${host.user}/.config/hypr
STATE_FILE=$SOURCE_FOLDER/.wallpaper_state
WALLPAPER_FOLDER=$SOURCE_FOLDER/wallpapers
WALLPAPER_AMOUNT=$(ls -1q $WALLPAPER_FOLDER | wc -l)

# Sanity checks
if ! [[ -d "$SOURCE_FOLDER" ]]; then
    echo "Source folder doesn't exist."
    exit 1
fi
if ! [[ -d "$WALLPAPER_FOLDER" ]]; then
    echo "Wallpaper folder doesn't exist."
    exit 1
fi
if [ $WALLPAPER_AMOUNT -lt 1 ]; then
    echo "There aren't any wallpapers in the wallpapers folder."
    exit 1
fi

# Defining wallpaper
if [ -f "$STATE_FILE" ]; then
    NUMBER=$(cat $STATE_FILE)
    if ! [[ $NUMBER =~ $re ]] ; then
        NUMBER=$((1 + $RANDOM % $WALLPAPER_AMOUNT))
    else 
        NUMBER=$(($NUMBER + 1))
        if [ $WALLPAPER_AMOUNT -lt $NUMBER ]; then
            NUMBER=1
        fi
    fi
else
    NUMBER=$((1 + $RANDOM % $WALLPAPER_AMOUNT))
fi

# echo "$(cat $STATE_FILE) -> $NUMBER"
echo $NUMBER > $STATE_FILE
${pkgs.swww}/bin/swww img --transition-step 4 --transition-fps 60 --transition-type any "$WALLPAPER_FOLDER/$(ls $WALLPAPER_FOLDER | head -$NUMBER | tail -1)"
  '';


  colorSchemePath = ".config/hypr/mocha.conf";
  launcherConfigPath = ".config/kickoff/config.toml";
  wallpapersFolderPath = ".config/hypr/wallpapers/";


  isNvidiaCard = if host.name == "zeus" then false else true;


  gestures = if host.name == "zeus" then ''
gestures {
    workspace_swipe = true
    workspace_swipe_invert = false
}
  '' else '''';


  input = if host.name == "zeus" then ''
input {
    kb_layout = us,ru
    kb_variant = dvorak,
    kb_options = grp:caps_toggle
    repeat_rate = 38
    repeat_delay = 340
    follow_mouse = 1
    touchpad {
        natural_scroll = false
        tap_button_map = lmr
        # drag_lock = true
        # tap-and-drag = true
    }
    sensitivity = 0
    force_no_accel = false
}
  '' else ''
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
    sensitivity = -0.5
    force_no_accel = 1
}
  '';
in {
  home.file.${wallpapersFolderPath} = {
    source = ./wallpapers;
    recursive = true;
  };
  wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      enableNvidiaPatches = isNvidiaCard;
      extraConfig = ''
source=~/${colorSchemePath}
monitor=,preferred,auto,auto

# Wayland/Hyprland environment varibles
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland
env = QT_AUTO_SCREEN_SCALE_FACTOR,1
env = QT_QPA_PLATFORM,wayland;xcb
env = GDK_BACKEND,wayland,x11
env = SDL_VIDEODRIVER,wayland
env = CLUTTER_BACKEND,wayland

exec-once = ${pkgs.systemd}/bin/systemctl --user start polkitkde.service
exec-once = ${pkgs.systemd}/bin/systemctl --user start kwallet.service
exec-once = ${pkgs.swww}/bin/swww-daemon
exec-once = sleep 0.2 && ${swww-change}/bin/swww-change

windowrule = workspace 2 silent, ^(brave-browser)$
windowrule = workspace 5 silent, ^(org.telegram.desktop)$
windowrule = workspace 4 silent, ^(YouTube Music)$
windowrule = float, ^(pavucontrol)$

general {
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
    rounding = 10
    blur {
        enabled = false
        size = 3
        passes = 1
    }
    drop_shadow = false
    # shadow_range = 4
    # shadow_render_power = 3
    # col.shadow = $surface0
    # col.shadow_inactive = $surface0
}

animations {
    enabled = yes

    bezier = windowsBezier, 0.16, 1, 0.3, 1
    bezier = workspacesBezier, 0.85, 0, 0.15, 1

    animation = windows, 1, 4, windowsBezier, slide
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 3, default
    animation = workspaces, 1, 3, workspacesBezier, slide
}

dwindle {
    pseudotile = yes
    preserve_split = yes # you probably want this
}

xwayland {
    force_zero_scaling = true
    use_nearest_neighbor = false
}

${input}

${gestures}

misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
}



bind = SUPER, V, togglefloating, 
bind = SUPER, R, pseudo
bind = SUPER, I, togglesplit,

bind = SUPER, J, cyclenext,
binde = SUPER, H, resizeactive, -20 0
binde = SUPER, L, resizeactive, 20 0

bind = SUPER SHIFT, S, exec, ${pkgs.slurp}/bin/slurp -d | ${pkgs.grim}/bin/grim -g - - | ${pkgs.imagemagick}/bin/convert - -shave 1x1 PNG:- | ${pkgs.wl-clipboard}/bin/wl-copy
bind = SUPER, F11, exec, ${swww-change}/bin/swww-change

bind = SUPER SHIFT, Return, exec, ${pkgs.kitty}/bin/kitty
bind = SUPER, P, exec, ${pkgs.kickoff}/bin/kickoff
bind = CTRL ALT, Backspace, exit, 
bind = SUPER SHIFT, F, fullscreen
bind = SUPER SHIFT, C, killactive, 
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER, 6, workspace, 6
bind = SUPER, 7, workspace, 7
bind = SUPER, 8, workspace, 8
bind = SUPER, 9, workspace, 9
bind = SUPER, 0, workspace, 10
bind = SUPER SHIFT, 1, movetoworkspacesilent, 1
bind = SUPER SHIFT, 2, movetoworkspacesilent, 2
bind = SUPER SHIFT, 3, movetoworkspacesilent, 3
bind = SUPER SHIFT, 4, movetoworkspacesilent, 4
bind = SUPER SHIFT, 5, movetoworkspacesilent, 5
bind = SUPER SHIFT, 6, movetoworkspacesilent, 6
bind = SUPER SHIFT, 7, movetoworkspacesilent, 7
bind = SUPER SHIFT, 8, movetoworkspacesilent, 8
bind = SUPER SHIFT, 9, movetoworkspacesilent, 9
bind = SUPER SHIFT, 0, movetoworkspacesilent, 10
bindm = SUPER, mouse:272, movewindow
bindm = SUPER, mouse:273, resizewindow
      '';
  };

  home.file.${launcherConfigPath}.text =
    "${builtins.readFile ./config.toml}";

  home.file.${colorSchemePath}.text =
    "${builtins.readFile ./mocha.conf}";
}
