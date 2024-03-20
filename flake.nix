{
  description = "Gleam v1.0.0";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }:

  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    
    gleam = (import ./default.nix {
	inherit pkgs;

	git = pkgs.git;
	erlang = pkgs.beam.interpreters.erlang_24;
	makeWrapper = pkgs.makeWrapper;
	fetchFromGithub = pkgs.fetchFromGitHub;
	rustPlatform = pkgs.rustPlatform;
	coreutils = pkgs.coreutils;
	rebar3 = pkgs.rebar3;
    });
  in
  {
    packages.${system}.default = gleam;

    devShells.${system}.default = (import ./shell.nix {
	mkShell = pkgs.mkShell;
	inherit gleam;
    });
  };
}
