# affinidi-ai/homebrew-tap

Homebrew casks for Affinidi command-line tools.

```sh
brew install --cask affinidi-ai/tap/boris
brew upgrade --cask affinidi-ai/tap/boris
```

Always use the fully qualified name: Homebrew then trusts this one item from
this tap, not every name it could resolve.

## boris

`Casks/boris.rb` installs the `boris` command-line client (macOS 12 or
later, Apple silicon and Intel). The binary is Developer ID signed and
notarized, so the cask has no `postflight` and never removes the quarantine
attribute: Gatekeeper's check of the download is real.

### How a new version arrives

Nobody edits `Casks/boris.rb` by hand. The boris release pipeline (the
`cli:publish:tap` job of a `cli-v<x.y.z>` tag in boris-md) renders the cask
from the signed release and opens a pull request here on a branch
`boris-<x.y.z>`. It never pushes to `main`. A CODEOWNER merges it; until
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
- the `cask` check on the pull request passed.

### Rolling back

Open a pull request putting `Casks/boris.rb` back to the previous version and
merge it after review. Released archives are never deleted, so the previous
URL and hashes still resolve.
