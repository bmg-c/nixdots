{...}: {
  programs.nixvim = {
    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2

      mapleader = " ";
      maplocalleader = " ";
    };
    options = {
      updatetime = 100;

      wrap = true;
      cursorline = true;
      cursorcolumn = false;
      signcolumn = "yes";
      colorcolumn = "81";
      relativenumber = true;
      number = true;
      hidden = true;

      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      scrolloff = 9;

      termguicolors = true;

      mouse = "a";
      mousemodel = "extend";

      splitbelow = true;
      splitright = true;

      swapfile = false;
      undofile = true;

      ignorecase = true;
      smartcase = true;
      hlsearch = false;
    };

    clipboard.providers.wl-copy.enable = true;
  };
}
