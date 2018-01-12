{ mkDerivation, base, Cabal, envy, servant-server, stdenv }:
mkDerivation {
  pname = "cabal-parser";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base Cabal envy servant-server ];
  homepage = "https://github.com/alunduil/librariesio-cabal-parser";
  description = "Tiny Web Service for Parsing Cabal Files";
  license = stdenv.lib.licenses.gpl3;
}
