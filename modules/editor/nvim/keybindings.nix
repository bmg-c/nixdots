{...}: {
  programs.nixvim.maps = {
    visual."<leader>y".action = "+y";
    normal."<leader>y".action = "+y";
    normal."<leader>yy".action = "+yy";
    normal."<leader>Y".action = "+yg_";

    visual."<leader>p".action = "+p";
    visual."<leader>P".action = "+P";
    normal."<leader>p".action = "+p";
    normal."<leader>P".action = "+P";

    normal."U".action = "<C-r>";
    visualOnly."U".action = "<nop>";
    visualOnly."u".action = "<nop>";
    normalVisualOp."gu".action = "<nop>";
    normalVisualOp."gU".action = "<nop>";

    # normalVisualOp."G".action = "<nop>";
    normalVisualOp."gl".action = "$";
    normalVisualOp."gs".action = "^";
    normalVisualOp."gh".action = "0";
    normalVisualOp."ge".action = "[[";
    normalVisualOp."gg".action = "G";
    normalVisualOp."gn" = {
      silent = true;
      action = ":bnext<CR>";
    };
    normalVisualOp."gp" = {
      silent = true;
      action = ":bprevious<CR>";
    };

    visualOnly."x".action = ''<S-v>'';

    normal."J" = {
      silent = true;
      action = '':move .+1<CR>=='';
    };
    normal."K" = {
      silent = true;
      action = '':move .-2<CR>=='';
    };
    visual."J" = {
      silent = true;
      action = '':move '>+1<CR>gv-gv'';
    };
    visual."K" = {
      silent = true;
      action = '':move '<-2<CR>gv-gv'';
    };

    normalVisualOp."<F1>".action = "<nop>";
  };
}
