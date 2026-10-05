{
  description = "nixos & home-manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      flake = {
        homeModules.default = { ... }: { }; # TODO
      };

      # The following stuff is only necessary for development
      imports = with inputs; [
        devshell.flakeModule
        treefmt-nix.flakeModule
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
