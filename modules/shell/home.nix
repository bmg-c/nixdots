# fish

{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [];
    shellInit = ''
      starship init fish | source
      fish_config theme choose "Catppuccin Mocha" 
    '';
    functions = {
      fish_greeting = {
        description = "Greeting to show when starting a fish shell";
        body = "
          ${pkgs.nitch}/bin/nitch
        ";
      };
    };
  };
  home.file.".config/fish/themes/Catppuccin Mocha.theme".text = ''
# name: 'Catppuccin mocha'
# url: 'https://github.com/catppuccin/fish'
# preferred_background: 1e1e2e

fish_color_normal cdd6f4
fish_color_command 89b4fa
fish_color_param f2cdcd
fish_color_keyword f38ba8
fish_color_quote a6e3a1
fish_color_redirection f5c2e7
fish_color_end fab387
fish_color_comment 7f849c
fish_color_error f38ba8
fish_color_gray 6c7086
fish_color_selection --background=313244
fish_color_search_match --background=313244
fish_color_option a6e3a1
fish_color_operator f5c2e7
fish_color_escape eba0ac
fish_color_autosuggestion 6c7086
fish_color_cancel f38ba8
fish_color_cwd f9e2af
fish_color_user 94e2d5
fish_color_host 89b4fa
fish_color_host_remote a6e3a1
fish_color_status f38ba8
fish_pager_color_progress 6c7086
fish_pager_color_prefix f5c2e7
fish_pager_color_completion cdd6f4
fish_pager_color_description 6c7086
  '';
  programs.starship =
    let
      flavour = "mocha";
    in
    {
      enable = true;
      settings = {
        format = "$all";
        palette = "catppuccin_${flavour}";
      } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
            sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          } + /palettes/${flavour}.toml));
    };
}
