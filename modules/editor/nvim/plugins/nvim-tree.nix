{...}: {
  programs.nixvim = {
    globals = {
      loaded_netrwPlugin = 1;
      loaded_netrw = 1;
      loaded_netrwSettings = 1;
      loaded_netrwFileHandlers = 1;
      loaded_netrw_gitignore = 1;
    };
    maps.normal."<leader>n" = {
      action = ":NvimTreeToggle<CR>";
      silent = true;
    };
    plugins.nvim-tree = {
      enable = true;
      disableNetrw = true;
      autoClose = true;
    };
  };
}
