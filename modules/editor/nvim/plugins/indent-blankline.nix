{...}: {
  programs.nixvim = {
    options.list = true;
    extraConfigLuaPre = ''vim.opt.listchars:append "eol:↴"'';
  };
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    showEndOfLine = true;
    spaceCharBlankline = " ";
    showCurrentContext = true;
    showCurrentContextStart = true;
    useTreesitter = true;
  };
}
