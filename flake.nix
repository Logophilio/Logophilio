{
  description = "Eclectic english vocab flashcard generator";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        python = pkgs.python3.withPackages (
          ps: with ps; [
            jinja2
            openai
            selenium
            webdriver-manager
            pypdf
            aiohttp
            frozendict
            unidecode
          ]
        );

        treefmtconfig = inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.black.enable = true;
          programs.isort.enable = true;
          programs.prettier.enable = true;
        };
      in
      {
        devShells = {
          default = pkgs.mkShell {
            packages =
              (with pkgs; [
                basedpyright
                ungoogled-chromium
              ])
              ++ [
                python
              ];
          };
        };
        formatter = treefmtconfig.config.build.wrapper;
        checks = {
          formatting = treefmtconfig.config.build.check self;
        };
      }
    );
}
