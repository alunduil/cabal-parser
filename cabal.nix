{ mkDerivation, array, base, binary, bytestring, containers
, deepseq, directory, filepath, pretty, process, QuickCheck, stdenv
, tagged, tar, tasty, tasty-hunit, tasty-quickcheck, time, unix
}:
mkDerivation {
  pname = "Cabal";
  version = "2.0.0.2";
  sha256 = "0chhl2113jbahd5gychx9rdqj1aw22h7dyj6z44871hzqxngx6bc";
  libraryHaskellDepends = [
    array base binary bytestring containers deepseq directory filepath
    pretty process time unix
  ];
  testHaskellDepends = [
    array base bytestring containers directory filepath pretty
    QuickCheck tagged tar tasty tasty-hunit tasty-quickcheck
  ];
  doCheck = false;
  homepage = "http://www.haskell.org/cabal/";
  description = "A framework for packaging Haskell software";
  license = stdenv.lib.licenses.bsd3;
}
