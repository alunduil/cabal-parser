# Description

Tiny Web Service for Parsing Cabal Files

Helper service for bibliothecary to parse cabal files from various sources.
Provides a fiat JSON represenation for a given cabal file posted to this HTTP API.

# Getting Started

Developer documentation can be generated with:

```bash
cabal haddock --executables
```

Once the documentation is generated, it is available at:
`./dist/doc/html/cabal-parser/cabal-parser/index.html`.

## Locally with [`docker-compose`][docker-compose]

This project is setup to run with [`docker-compose`][docker-compose].  Running
the following command will build a [docker] image (includes building
cabal-parser), and start all requisite services as [docker] containers.

```bash
docker-compose up -d
```

cabal-parser will be available at <http://localhost:PORT> once this
command finishes executing.  You can get `PORT` from `docker ps`.

## Locally with [`nix-shell`][nix-shell]

This project is setup with [`nix-shell`][nix-shell].  Running the following
command will build a local development environment where all of the
supplementary tools are pre-installed.

```bash
nix-env -i cabal
nix-shell
```

Once this command finishes executing, the libraries and other tools are
available.  You will still need to have cabal installed another way.

## Others

This project utilizes [`cabal`][cabal] like most [Haskell] projects and the
standard [Haskell] development environment for your platform should work just
fine.

[cabal]: https://www.haskell.org/cabal/
[docker-compose]: https://docs.docker.com/compose/
[docker]: https://docs.docker.com/
[Haskell]: https://www.haskell.org/
[nix-shell]: https://nixos.org/nix/manual/#sec-nix-shell
