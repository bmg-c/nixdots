{
  pkgs,
  host,
  ...
}: {
  imports = [./plugins];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [asvetliakov.vscode-neovim];
  };
  # home.file."/home/${host.user}/.config/VSCodium/User/settings.json".text = builtins.readFile ./settings.json;
}
