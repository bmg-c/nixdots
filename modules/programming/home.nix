{
  pkgs,
  host,
  ...
}: {
  programs.java = {
    enable = true;
    package = pkgs.jdk;
  };

  home.packages = with pkgs; [
    rustc
    cargo

    gradle
  ];
}
