{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # url = "/home/gaetan/perso/nix/nixvim/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
    homeManagerModules = [
      nixvim.homeManagerModules.nixvim
    ];
  in {
    nixosConfigurations = {
      zeus = lib.nixosSystem {
        inherit system;
        specialArgs = {
          host = {
            name = "zeus";
            user = "ivan";
          };
        };
        modules = [
          ./config.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              host = {
                name = "zeus";
                user = "ivan";
              };
            };
            home-manager.users.ivan = {
              imports =
                [
                  ./home.nix
                ]
                ++ homeManagerModules;
            };
          }
        ];
      };
      hades = lib.nixosSystem {
        inherit system;
        specialArgs = {
          host = {
            name = "hades";
            user = "ivan";
          };
        };
        modules = [
          ./config.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              host = {
                name = "hades";
                user = "ivan";
              };
            };
            home-manager.users.ivan = {
              imports = [
                ./home.nix
              ];
            };
          }
        ];
      };
    };
  };
}
