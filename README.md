# Delixon Labs Homebrew tap

Homebrew formulae for [QiloBack](https://qiloback.dev) and other Delixon Labs CLIs.

## Install QiloBack

```bash
brew tap delixon-labs/tap
brew install qiloback
```

Or in one line without the explicit tap:

```bash
brew install delixon-labs/tap/qiloback
```

## Update

```bash
brew upgrade qiloback
```

## Remove

```bash
brew uninstall qiloback
brew untap delixon-labs/tap   # optional
```

## How this tap is maintained

Formulae here are updated automatically by the
[`release-package-managers.yaml`](https://github.com/delixon-labs/qiloback-core/blob/main/.github/workflows/release-package-managers.yaml)
workflow in the [QiloBack core repository](https://github.com/delixon-labs/qiloback-core)
on every `v*.*.*` tag push. The workflow:

1. Builds the cross-platform binaries.
2. Computes their SHA-256 sums.
3. Updates `Formula/qiloback.rb` with the new version + sha256s.
4. Opens a PR against this repository (or pushes directly when run
   under the `release` branch protection rule).

You should not edit these files by hand — the next release will
overwrite your changes.

## Reporting issues

The CLI itself lives at
[`delixon-labs/delixon-qiloback`](https://github.com/delixon-labs/delixon-qiloback).
Open issues there, not here. This tap is just the publishing
shell.

## License

Functional Source License 1.1, Apache 2.0 Future License
([FSL-1.1-ALv2](https://fsl.software/)).
See the upstream
[LICENSE](https://github.com/delixon-labs/delixon-qiloback/blob/main/LICENSE)
for full terms.
