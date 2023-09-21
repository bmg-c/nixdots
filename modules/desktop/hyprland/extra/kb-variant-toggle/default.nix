{
  pkgs,
  host,
  ...
}: let
  kb-variant-toggle = pkgs.writeShellScriptBin "kb-variant-toggle" ''
    #!/bin/sh

    SOURCE_FOLDER=/home/${host.user}/.config/hypr
    STATE_FILE=$SOURCE_FOLDER/.kbstate

    # Sanity checks
    if ! [[ -d "$SOURCE_FOLDER" ]]; then
        echo "Source folder doesn't exist."
        exit 1
    fi

    if [ -f "$STATE_FILE" ]; then
        if [ $(cat $STATE_FILE) = "1" ]; then
            ${pkgs.hyprland}/bin/hyprctl reload
            echo "0" > $STATE_FILE
        else
            ${pkgs.hyprland}/bin/hyprctl keyword input:kb_variant ""
            echo "1" > $STATE_FILE
        fi
    else
        ${pkgs.hyprland}/bin/hyprctl keyword input:kb_variant ""
        echo "1" > $STATE_FILE
    fi
  '';
in {
  wayland.windowManager.hyprland.extraConfig = ''
    bind = SUPER, F10, exec, ${kb-variant-toggle}/bin/kb-variant-toggle
  '';
}
