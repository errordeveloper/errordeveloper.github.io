{
  description = "A small Hugo technical blog";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            packages = [ pkgs.hugo ];
          };
        });

      packages = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          site = pkgs.stdenvNoCC.mkDerivation {
            pname = "technical-blog";
            version = "0.1.0";
            src = self;
            nativeBuildInputs = [ pkgs.hugo ];
            buildPhase = ''
              export HOME="$TMPDIR"
              hugo --minify --destination "$out"
            '';
            installPhase = "true";
          };
          default = self.packages.${system}.site;
        });
    };
}

