# The fabric CLI cask, rendered by scripts/homebrew-cask.sh in
# affinidi-ai/affinidi-trust-fabric-cli for one release. The release opens a
# pull request on the tap with this file; it never pushes, and nobody edits
# it by hand. The url is the versioned release archive and each sha256
# comes from the release's SHA256SUMS. There is no postflight and no
# quarantine removal: the binary is Developer ID signed and notarized, so
# Gatekeeper's check of the quarantined download is real.
#
#   brew install --cask affinidi-ai/tap/fabric
cask "fabric" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.1.3"
  sha256 arm:   "dba9cf3fa29c3b3489bf5bf34e4df2a17b2c8746a2786de6169001f232b03a6d",
         intel: "21c2e8b7bd656e8c1519d2e721525b9577192c8f7f8b417e153c09d948839150"

  url "https://github.com/affinidi-ai/affinidi-trust-fabric-cli/releases/download/v#{version}/fabric-#{version}-#{arch}-apple-darwin.tar.gz"
  name "fabric"
  desc "Command-line client for Affinidi appliances, starting with Agent Gateway"
  homepage "https://github.com/affinidi-ai/affinidi-trust-fabric-cli"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  # The archive holds a folder named after itself, as the Linux ones do.
  binary "fabric-#{version}-#{arch}-apple-darwin/fabric"
end
