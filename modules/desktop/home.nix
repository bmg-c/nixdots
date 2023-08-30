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

exec-once = ${pkgs.systemd}/bin/systemctl --user start polkitkde.service
exec-once = ${pkgs.systemd}/bin/systemctl --user start kwallet.service
exec-once = ${pkgs.swww}/bin/swww-daemon
exec-once = sleep 0.2 && ${swww-change}/bin/swww-change

# Wayland/Hyprland environment varibles
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland
env = QT_AUTO_SCREEN_SCALE_FACTOR,1
env = QT_QPA_PLATFORM,wayland;xcb
env = GDK_BACKEND,wayland,x11
env = SDL_VIDEODRIVER,wayland
env = CLUTTER_BACKEND,wayland

xwayland {
    force_zero_scaling = true
    use_nearest_neighbor = false
}

${input}

${gestures}

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
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10
    blur {
        enabled = true
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

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more new_is_master = true 
}

misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
}

windowrule = workspace 2 silent, ^(brave-browser)$
windowrule = workspace 5 silent, ^(org.telegram.desktop)$


$mainMod = SUPER

bind = $mainMod, V, togglefloating, 
bind = $mainMod, R, pseudo
bind = $mainMod, I, togglesplit,

bind = $mainMod, J, cyclenext,
binde = $mainMod, H, resizeactive, -20 0
binde = $mainMod, L, resizeactive, 20 0

bind = $mainMod, F11, exec, ${swww-change}/bin/swww-change

bind = $mainMod SHIFT, Return, exec, ${pkgs.kitty}/bin/kitty
bind = $mainMod, P, exec, ${pkgs.kickoff}/bin/kickoff
bind = CTRL ALT, Backspace, exit, 
bind = $mainMod SHIFT, F, fullscreen
bind = $mainMod SHIFT, C, killactive, 
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
bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
      '';
  };

  home.file.${launcherConfigPath}.text =
    "${builtins.readFile ./config.toml}";

  home.file.${colorSchemePath}.text =
    "${builtins.readFile ./mocha.conf}";
}
