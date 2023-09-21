# fish
{
  pkgs,
  host,
  ...
}: {
  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;
    users.${host.user}.useDefaultShell = true;
  };
}
