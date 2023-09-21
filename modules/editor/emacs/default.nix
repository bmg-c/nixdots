{...}: {
  programs.emacs = {
    enable = true;
    extraConfig = ''
      (use-package evil
        :config
        (evil-mode 1)
      )
    '';
    extraPackages = epkgs: [
      epkgs.evil
      epkgs.evil-dvorak
    ];
  };
}
