{
  pkgs,
  host,
  ...
}: let
  # nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
  #   export __NV_PRIME_RENDER_OFFLOAD=1
  #   export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  #   export __GLX_VENDOR_LIBRARY_NAME=nvidia
  #   export __VK_LAYER_NV_optimus=NVIDIA_only
  #
  #   exec "$@"
  # '';
  fileImports =
    if host.name == "zeus"
    then [./hwconf/hwconf-zeus.nix] ++ (import ./modules/config-default.nix)
    else [./hwconf/hwconf-hades.nix] ++ (import ./modules/config-default.nix);

  hardwareOpenglExtraPackages =
    if host.name == "zeus"
    then [
      pkgs.rocm-opencl-icd
      pkgs.rocm-opencl-runtime
    ]
    else [];
  hardwareNvidia =
    if host.name == "zeus"
    then {}
    else {
      # modesetting.enable = false;
      # open = false;
      # prime = {
      #   offload.enable = true; # Enable PRIME offloading
      #   intelBusId = "PCI:0:2:0"; # lspci | grep VGA | grep Intel
      #   nvidiaBusId = "PCI:1:0:0"; # lspci | grep VGA | grep NVIDIA
      # };
    };
  servicesXserverVideoDrivers =
    if host.name == "zeus"
    then ["amdgpu"]
    # else ["nvidia"];
    # else ["modesetting" "nvidia"];
    else ["modesetting"];
  bootInitrdKernelModules =
    if host.name == "zeus"
    then ["amdgpu"]
    else [];
  # else ["i915"];
  bootKernelParams =
    if host.name == "zeus"
    then []
    else [];

  environmentVariables =
    if host.name == "zeus"
    then {
      EDITOR = "nvim";
      VISUAL = "nvim";
      XCURSOR_SIZE = "24";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      AMD_VULKAN_ICD = "RADV";
    }
    else {
      EDITOR = "nvim";
      VISUAL = "nvim";
      XCURSOR_SIZE = "24";
      # LIBVA_DRIVER_NAME = "nvidia";
      # GBM_BACKEND = "nvidia-drm";
      # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

  extraPackages =
    if host.name == "zeus"
    then
      with pkgs; [
        acpi
        brightnessctl
      ]
    else
      with pkgs; [
        # nvidia-offload
      ];
in {
  imports = fileImports;
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot = {
    kernelParams = bootKernelParams;
    kernelPackages = pkgs.linuxPackages_zen;
    initrd.kernelModules = bootInitrdKernelModules;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      systemd-boot.consoleMode = "max";
      timeout = 2;
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
      extraPackages = hardwareOpenglExtraPackages;
    };
    nvidia = hardwareNvidia;
  };
  services.xserver = {
    enable = true;
    libinput.enable = true;
    videoDrivers = servicesXserverVideoDrivers;
  };

  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.${host.user} = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "input" "networkmanager"];
  };
  security.sudo = {
    enable = true;
    extraConfig = ''
      ${host.user} ALL=(ALL) NOPASSWD:ALL
    '';
  };

  environment.variables = environmentVariables;

  environment.systemPackages = with pkgs;
    [
      brave
      pavucontrol
      telegram-desktop
      github-desktop
      youtube-music

      wget
      git
      wl-clipboard
      xdg-utils
      tldr
      nodejs
      unzip
      gcc
      # glxinfo
      tree
      libreoffice-still
    ]
    ++ extraPackages;

  fonts.packages = with pkgs; [
    noto-fonts-cjk
    openmoji-color
    # font-awesome
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
  ];

  system.stateVersion = "23.05";
}
