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

  version "0.1.2"
  sha256 arm:   "ba511a5eb594826170103a508e49eb64986721f7df03d566a36922a6227d8d2b",
         intel: "28a5a64ab9bc5c86a45eaa24d40ca43bd7ec4f992799fbd86923706bb7ff4fa9"

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
