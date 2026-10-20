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

  version "0.1.4"
  sha256 arm:   "4259749f92f7b617332884eaec37fb9cd6c01ab64f9c7f1a0d3a4356a7cce498",
         intel: "32066d2f1f4fbb1ba5ad353473c62c327ebb6e3b2fc541cb39692701867c8923"

  url "https://releases.trustboris.ai/boris/v#{version}/boris-#{version}-#{arch}-apple-darwin.tar.gz"
  name "boris"
  desc "Command-line client for Boris: sign in, plan and apply changes, run the tunnel"
  homepage "https://trustboris.ai/cli"

  # The signed pointer to the newest stable release; a pre-release never
  # moves it, so the tap's audit skips this check for an rc.
  livecheck do
    url "https://releases.trustboris.ai/boris/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on macos: :monterey

  binary "boris"
end
