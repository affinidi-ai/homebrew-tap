# The boris CLI cask, rendered by clients/homebrew/render.sh for one release
# (docs/AGENT_CONTROL_PHASE3_SPEC.md P40). The release opens a pull request
# on the tap with this file; it never pushes. The url is the immutable,
# versioned archive and each sha256 comes from the signed SHA256SUMS. There is
# no postflight and no quarantine removal: the binary is Developer ID signed
# and notarized, so Gatekeeper's check of the quarantined download is real.
#
#   brew install --cask affinidi-ai/tap/boris
cask "boris" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.1.0-rc.8"
  sha256 arm:   "7ed7168ea3b40f259034becd6e1914f3d77b285ab9ae498b0478db2108a8d70a",
         intel: "6a2891196973fefb1b02d26b20e0b384e1c6446a3f9228d537b9e74efaf12b3c"

  url "https://releases.trustboris.ai/boris/v#{version}/boris-#{version}-#{arch}-apple-darwin.tar.gz"
  name "boris"
  desc "Command-line client for Boris: sign in, plan and apply changes, run the tunnel"
  homepage "https://trustboris.ai/cli"

  depends_on macos: ">= :monterey"

  binary "boris"
end
