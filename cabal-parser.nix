let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {

          Cabal =
            haskellPackagesNew.callPackage ./cabal.nix { };

          cabal-parser =
            haskellPackagesNew.callPackage ./default.nix { };

        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };
in
  { cabal-parser = pkgs.haskellPackages.cabal-parser;
  }
