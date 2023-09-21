{host, ...}: let
  input =
    if host.name == "zeus"
    then ''
      input {
          touchpad {
              natural_scroll = false
              tap_button_map = lmr
          }
          sensitivity = 0
          force_no_accel = false
      }
    ''
    else ''
      input {
          touchpad {
              natural_scroll = no
          }
          sensitivity = -0.5
          force_no_accel = 1
      }
    '';
  gestures =
    if host.name == "zeus"
    then ''
      gestures {
          workspace_swipe = true
          workspace_swipe_invert = false
      }
    ''
    else '''';
in {
  wayland.windowManager.hyprland.extraConfig = ''
    input {
        kb_layout = us,ru
        kb_variant = dvorak,
        kb_options = grp:caps_toggle
        repeat_rate = 38
        repeat_delay = 340
        follow_mouse = 1
    }
    ${input}
    ${gestures}
  '';
}
