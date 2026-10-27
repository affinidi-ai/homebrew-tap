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

  version "0.1.14"
  sha256 arm:   "ab4c31e744f16af42cb14d8c06b4712007760bd175a41d8696dd595c366da9fb",
         intel: "a78d30953ba4e085373f17d8d8c2eb23f02e6fa877b1be33884b8464c9cf3478"

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
