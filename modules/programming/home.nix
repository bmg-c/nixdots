{
  pkgs,
  host,
  ...
}: {
    programs.java = {
      enable = true;
      package = pkgs.jdk;
    };
}
