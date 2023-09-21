{config, ...}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      # folding = true;
      indent = true;

      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        bash
        c
        lua
        nix
        python
        rust
        java
      ];
    };
    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
    };
  };
}
