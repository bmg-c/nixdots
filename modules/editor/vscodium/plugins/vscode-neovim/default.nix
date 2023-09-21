{...}: {
  programs.nixvim.extraConfigLuaPre = builtins.readFile ./init.lua;
  programs.nixvim.extraConfigLuaPost = "end";
}
