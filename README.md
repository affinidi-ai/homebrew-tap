# affinidi-ai/homebrew-tap

Homebrew casks for Affinidi command-line tools.

```sh
# macOS
brew install --cask affinidi-ai/tap/boris
brew upgrade --cask affinidi-ai/tap/boris

# Linux
brew install affinidi-ai/tap/boris
brew upgrade affinidi-ai/tap/boris
```

Always use the fully qualified name: Homebrew then trusts this one item from
this tap, not every name it could resolve.

## boris

`Casks/boris.rb` installs the `boris` command-line client on macOS (12 or
later, Apple silicon and Intel). The binary is Developer ID signed and
notarized, so the cask has no `postflight` and never removes the quarantine
attribute: Gatekeeper's check of the download is real.

`Formula/boris.rb` installs the same release on Linux (arm64 and x86_64, a
static musl binary). It is Linux only: a formula's download carries no
quarantine, so on macOS Gatekeeper would never check the notarization. With
the same name for both, brew picks the formula unless `--cask` is given, which
is why the macOS command always carries it.

### How a new version arrives

Nobody edits `Casks/boris.rb` or `Formula/boris.rb` by hand. The boris
release pipeline (the `cli:publish:tap` job of a `cli-v<x.y.z>` tag in
boris-md) renders both from the signed release and opens one pull request
here on a branch `boris-<x.y.z>`. It never pushes to `main`. A CODEOWNER merges it; until
then `brew` keeps installing the previous version.

The pipeline authenticates with a GitHub App installed on this repository
only (contents and pull requests). `main` is protected, and the App is not on
its bypass list, so the App alone cannot change what `brew` installs.

### Reviewing a release pull request

Before approving, check that:

- the title and `version` are the `cli-v<x.y.z>` tag that was released, and
  the boris-md pipeline for that tag passed `cli:release:check`;
- `url` is `https://<release host>/boris/v#{version}/boris-#{version}-#{arch}-apple-darwin.tar.gz`,
  the immutable versioned path, on the release host boris-md commits in
  `clients/boris-cli/release-host`;
- both `sha256` values match the release's `SHA256SUMS` (whose signature
  `SHA256SUMS.sig` verifies with boris-md's `clients/boris-cli/release-key.pub`);
- the cask has no `preflight`, `postflight`, `system_command`, `xattr` or
  quarantine handling;
- in `Formula/boris.rb`: the same `version`, two `url`s, the
  `aarch64-unknown-linux-musl` and `x86_64-unknown-linux-musl` archives under
  the same versioned path, their `sha256` from the same `SHA256SUMS`, and
  `install` is `bin.install "boris"` alone;
- the `cask` and `formula` checks on the pull request passed.

### Rolling back

Open a pull request putting `Casks/boris.rb` and `Formula/boris.rb` back to
the previous version and merge it after review. Released archives are never deleted, so the previous
URL and hashes still resolve.

## fabric

`Casks/fabric.rb` installs `fabric`, the Affinidi Trust Fabric command-line
client (macOS 12 or later, Apple silicon and Intel). The binary is Developer
ID signed and notarized, so the cask has no `postflight` and never removes the
quarantine attribute.

```sh
brew install --cask affinidi-ai/tap/fabric
brew upgrade --cask affinidi-ai/tap/fabric
```

Homebrew also has an unrelated `fabric` formula, so the fully qualified name
matters here.

### How a new version arrives

Nobody edits `Casks/fabric.rb` by hand. Once the `release` workflow of a
`v<x.y.z>` tag passes in affinidi-ai/affinidi-trust-fabric-cli, its
`homebrew-tap` workflow renders the cask from the release's `SHA256SUMS` and
opens a pull request here on a branch `fabric-<x.y.z>`, titled
`chore(cask): fabric <x.y.z>`. It never pushes to `main`. A CODEOWNER from
`@affinidi-ai/affinidi-fabric-cli-codeowners` merges it; until then `brew`
keeps installing the previous version.

The workflow authenticates with the CLI release bot GitHub App, using a token
limited to this repository's contents and pull requests. The App is on the
bypass list of `main`'s ruleset, as on every repository it releases, so the
workflow only ever writes to its `fabric-<x.y.z>` branch and opening a pull
request is the last thing it does.

### Reviewing a release pull request

Before approving, check that:

- the title and `version` are `<x.y.z>`, from the `v<x.y.z>` tag that was
  released, and the CLI's `release` workflow for that tag passed;
- `url` is `https://github.com/affinidi-ai/affinidi-trust-fabric-cli/releases/download/v#{version}/fabric-#{version}-#{arch}-apple-darwin.tar.gz`,
  the versioned release archive;
- both `sha256` values match the release's `SHA256SUMS`;
- the cask has no `preflight`, `postflight`, `system_command`, `xattr` or
  quarantine handling;
- the `cask` check on the pull request passed.

### Rolling back

First make the previous release GitHub's latest again, for example
`gh release edit v<previous> --latest -R affinidi-ai/affinidi-trust-fabric-cli`,
or mark the bad release as a pre-release. The cask's livecheck reads GitHub's
latest release, so until then the `cask` check's audit fails for the older
version. Then open a pull request
putting `Casks/fabric.rb` back to the previous version and merge it after
review. The previous release's archives stay on its GitHub Release, so the
previous URL and hashes still resolve.
