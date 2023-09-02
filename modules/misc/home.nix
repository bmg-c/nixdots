# htop, gtk theme, mpv
{
  pkgs,
  host,
  ...
}: {
  # programs.htop = {
  #   enable = true;
  #   settings = {
  #     fields = with config.lib.htop.fields; [
  #       PERCENT_CPU
  #       PERCENT_MEM
  #       COMM
  #     ];
  #   };
  # };
  programs.btop = {
    enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Pink-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["pink"];
        size = "standard";
        tweaks = [];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  programs.mpv.enable = true;

  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "${pkgs.gtklock}/bin/gtklock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
      {
        "label" = "logout";
        "action" = "loginctl terminate-user $USER";
        "text" = "Logout";
        "keybind" = "e";
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "Shutdown";
        "keybind" = "s";
      }
      {
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
    ];
    style = ''
      * {
      	background-image: none;
      }
      window {
      	background-color: rgba(12, 12, 12, 0.9);
      }
      button {
          color: #FFFFFF;
      	background-color: #1E1E2E;
      	border-style: solid;
      	border-width: 2px;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      }

      button:focus, button:active, button:hover {
      	background-color: #764368;
      	outline-style: none;
      }

      #lock {
          background-image: image(url("/home/${host.user}/.config/wlogout/icons/lock.png"));
      }

      #logout {
          background-image: image(url("/home/${host.user}/.config/wlogout/icons/logout.png"));
      }

      #suspend {
          background-image: image(url("/home/${host.user}/.config/wlogout/icons/suspend.png"));
      }

      #hibernate {
          background-image: image(url("/home/${host.user}/.config/wlogout/icons/hibernate.png"));
      }

      #shutdown {
          background-image: image(url("/home/${host.user}/.config/wlogout/icons/shutdown.png"));
      }

      #reboot {
          background-image: image(url("/home/${host.user}/.config/wlogout/icons/reboot.png"));
      }
    '';
  };
  home.file.".config/wlogout/icons/" = {
    source = ./icons;
  };

  # services.mako = {
  #   enable = true;
  # };
  # home.packages = with pkgs; [ libnotify ];
}
