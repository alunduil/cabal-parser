{ mkDerivation, aeson, base, Cabal, envy, hspec, servant-server
, stdenv, text, utf8-string, warp
}:
mkDerivation {
  pname = "cabal-parser";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base Cabal envy servant-server text utf8-string warp
  ];
  testHaskellDepends = [ base hspec ];
  homepage = "https://github.com/alunduil/librariesio-cabal-parser";
  description = "Tiny Web Service for Parsing Cabal Files";
  license = stdenv.lib.licenses.gpl3;
}
