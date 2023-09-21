# QWERTY shortcuts for dvorak layout, kwallet, kde polkit agent, pfetch with
# kitties, gtk theming (dconf), greetd (tuigreet)
{
  pkgs,
  host,
  ...
}: let
  dvorak = {
    package = pkgs.stdenv.mkDerivation rec {
      name = "dvorak";
      src = pkgs.fetchFromGitHub {
        owner = "bmg-c";
        repo = "dvorak";
        rev = "ff9bd9cd095292faed12c35c92266bb3db59c526";
        sha256 = "fieNcEviTGagXO+ivizamlSwo5NCndpJuNPBwBbbD2M=";
      };
      installPhase = ''
        mkdir -p $out/bin
        cp dvorak $out/bin/dvorak
      '';
    };
    service =
      if host.desktop == "hyprland"
      then {
        enable = true;
        description = "Dvorak Virtual Keyboard";
        serviceConfig.ExecStart =
          if host.name == "zeus"
          then ''${dvorak.package}/bin/dvorak -d /dev/input/by-path/platform-i8042-serio-0-event-kbd -m "AT Translated Set 2 keyboard"''
          else ''${dvorak.package}/bin/dvorak -d /dev/input/by-id/usb-Logitech_USB_Keyboard-event-kbd -m "Logitech USB Keyboard"'';
        wantedBy = ["default.target"];
      }
      else {};
  };

  kwallet = {
    package = pkgs.libsForQt5.kwallet;
    service =
      if host.kwallet == true
      then {
        enable = true;
        description = "KDE Wallet Service";
        serviceConfig.ExecStart = ''${pkgs.libsForQt5.kwallet}/bin/kwalletd5'';
        wantedBy = ["default.target"];
      }
      else {};
  };

  polkitkde = {
    package = pkgs.libsForQt5.kwallet;
    service =
      if host.polkitkde == true
      then {
        enable = true;
        description = "KDE Polkit Agent";
        serviceConfig.ExecStart = ''${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1'';
        wantedBy = ["default.target"];
      }
      else {};
  };
in {
  imports = [
    ./dconf
    ./greetd
    ./plymouth
  ];
  systemd.services.dvorak = dvorak.service;
  systemd.user.services.kwallet = kwallet.service;
  systemd.user.services.polkitkde = polkitkde.service;

  environment.systemPackages = [
    # dvorak.package
    # kwallet.package
    # polkitkde.package
  ];
}
