{
  description = "a home manager module for easily managing mutable but reproducible files with diff generation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      flake.homeModules.default = ./home-module.nix;

      # The following is only relevant for development.
      imports = with inputs; [
        # Handle downstream flakes setting input-follows to "".
        devshell.flakeModule or ({ ... }: { })
        treefmt-nix.flakeModule or ({ ... }: { })
      ];
      perSystem = { pkgs, ... }: {
        devshells.default = (
          { extraModulesPath, ... }: {
            name = "dev";
            imports = [ "${extraModulesPath}/git/hooks.nix" ];

            packages = with pkgs; [ nixd ]; # LSP for Nix
            git.hooks = {
              enable = true;
              pre-commit.text = "nix flake check";
            };
          }
        );

        # Run with `nix fmt`
        treefmt = {
          programs.mdformat.enable = true;
          programs.nixfmt.enable = true;
        };
      };
    };
}
