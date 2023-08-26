{ config, pkgs, host, ... }:

let
  fileImports = if host.name == "zeus" then
    [ ./hwconf/hwconf-zeus.nix ] ++ ( import ./modules/config-default.nix)
    else
    [ ./hwconf/hwconf-hades.nix ] ++ (import ./modules/config-default.nix);


  hardwareNvidia = if host.name == "zeus" then {} else {
    modesetting.enable = true;
    open = false;
  };
  servicesXserverVideoDrivers = if host.name == "zeus" then [] else [ "nvidia" ];
in {
  imports = fileImports;
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot = {
    loader = {    
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      systemd-boot.consoleMode = "max";
      timeout = 2;
    };
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
      };
    };
  };


  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = false;
  };
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    extraConfig = ''
      DefaultTimeoutStopSec = 10s
    '';
  };
  time.timeZone = "Asia/Tomsk";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "dvorak";


  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = hardwareNvidia;
  };
  services.xserver = {
    enable = false;
    videoDrivers = servicesXserverVideoDrivers;
    displayManager.lightdm.enable = false;
  };


  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  users = {
    # defaultUserShell = pkgs.fish;
    users.${host.user} = {
      isNormalUser = true;
      # useDefaultShell = true;
      extraGroups = [ "wheel" "video" "audio" "input" "networkmanager" ];
    };
  };

  environment.systemPackages = with pkgs; [
    wofi
    brave
    pavucontrol
    telegram-desktop
    github-desktop
    youtube-music
    
    vim
    neovim
    wget
    git
    wl-clipboard
    xdg-utils

    xorg.xorgserver
    xorg.xf86inputlibinput
  ];


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [
      "FiraCode"
      "JetBrainsMono"
    ]; })
  ];


  system.stateVersion = "23.05";
}

