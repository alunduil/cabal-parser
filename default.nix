{ mkDerivation, aeson, base, bytestring, Cabal, envy, hspec
, hspec-discover, pretty, servant-server, stdenv, text, utf8-string
, wai-extra, warp
}:
mkDerivation {
  pname = "cabal-parser";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base Cabal envy pretty servant-server text utf8-string
    wai-extra warp
  ];
  testHaskellDepends = [
    aeson base bytestring Cabal hspec pretty text
  ];
  testToolDepends = [ hspec-discover ];
  homepage = "https://github.com/alunduil/librariesio-cabal-parser";
  description = "Tiny Web Service for Parsing Cabal Files";
  license = stdenv.lib.licenses.gpl3;
}
