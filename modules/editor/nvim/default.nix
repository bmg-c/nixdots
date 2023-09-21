{...}: {
  imports = [
    ./options.nix
    ./colors.nix
    ./plugins
    ./keybindings.nix
  ];

  programs.nixvim = {
    enable = true;

    luaLoader.enable = true;
    extraConfigLuaPost = builtins.readFile ./extraConfig.lua;
  };
}
