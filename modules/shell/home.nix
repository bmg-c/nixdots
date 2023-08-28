# fish

{ pkgs, ... }:

let
  pfetch.package = pkgs.stdenv.mkDerivation rec {
    name = "pfetch";
    src = pkgs.fetchFromGitHub {
      owner = "andreasgrafen";
      repo = "pfetch-with-kitties";
      rev = "f70c7d1a4b977efb1051b4ba1fd553d4d6708dba";
      sha256 = "1s4ypIemW750a4y0sIeI2JgX3tJP+sblDjFl/CWO4ps=";
    };

    installPhase = ''
      mkdir -p $out/bin
      cp pfetch $out/bin/pfetch
    '';
  };
in {
  programs.fish = {
    enable = true;
    shellInit = ''
      starship init fish | source
      fish_config theme choose "Catppuccin Mocha" 
    '';
    shellAbbrs = {
      rm = ''rm -vrf'';
      cp = ''cp -vr'';
    };
    shellAliases = {
      clear = ''clear && printf "\e[31m●\e[0m \e[33m●\e[0m \e[32m●\e[0m \e[36m●\e[0m \e[34m●\e[0m \e[35m●\e[0m \n\n\n" && PF_INFO="ascii title os uptime pkgs" PF_SEP="       " PF_COL1=4 PF_COL2=9 PF_COL3=1 PF_ALIGN="" PF_ASCII="Catppuccin" ${pfetch.package}/bin/pfetch'';
      c = ''clear'';
      t = ''tldr'';
    };
    functions = {
      fish_greeting = {
        description = "Greeting";
        body = ''printf "\e[31m●\e[0m \e[33m●\e[0m \e[32m●\e[0m \e[36m●\e[0m \e[34m●\e[0m \e[35m●\e[0m \n\n\n" && PF_INFO="ascii title os uptime pkgs" PF_SEP="       " PF_COL1=4 PF_COL2=9 PF_COL3=1 PF_ALIGN="" PF_ASCII="Catppuccin" ${pfetch.package}/bin/pfetch'';
      };
    };
  };
  home.file.".config/fish/themes/Catppuccin Mocha.theme".text = ''
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
