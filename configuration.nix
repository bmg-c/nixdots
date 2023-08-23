# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
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
  time.timeZone = "Asia/Tomsk";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "dvorak";
  };


  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
    };
  };
  services.xserver = {
    enable = false;
    videoDrivers = ["nvidia"];
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


  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      enableNvidiaPatches = true;
    };
    fish = {
      enable = true;
    };
  };

  users = {
    defaultUserShell = pkgs.fish;
    users.hades = {
      isNormalUser = true;
      useDefaultShell = true;
      extraGroups = [ "wheel" "video" "audio" "input" "networkmanager" ];
      packages = with pkgs; [];
    };
  };

  environment.systemPackages = with pkgs; [
    wofi
    brave
    kitty
    pavucontrol
    telegram-desktop
    github-desktop
    
    vim
    neovim
    wget
    git

    # greetd.greetd
    # greetd.tuigreet

    xorg.xorgserver
    xorg.xf86inputlibinput
  ];

  # system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
}

