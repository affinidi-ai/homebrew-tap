# The boris CLI cask, rendered by clients/homebrew/render.sh for one release
# (docs/AGENT_CONTROL_PHASE3_SPEC.md P40). The release opens a pull request
# on the tap with this file; it never pushes. The url is the immutable,
# versioned archive and each sha256 comes from the signed SHA256SUMS. There is
# no postflight and no quarantine removal: the binary is Developer ID signed
# and notarized, so Gatekeeper's check of the quarantined download is real.
# The same cask installs the static musl binary on Linux (Homebrew's casks
# support Linux), so one name and one command serve both.
#
#   brew install --cask affinidi-ai/tap/boris
cask "boris" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "apple-darwin", linux: "unknown-linux-musl"

  version "0.1.18"
  sha256 arm:          "aa0c49b0815be561442deeb1f62bf58fc90a0dceb6d680d3674c34800776239e",
         intel:        "9d55b59e37c1ea9f507818ad5000e429ffda2b2d65e9fadf26559d7b719d155f",
         arm64_linux:  "bd96ecfbb937fe440ea2e8f104b8b4f3f5bf28a4ef077ea885067305ef94c635",
         x86_64_linux: "35ce193cb12453e2db4bb20935bd0853db7df4b3296ccc4d47beede14dd47e37"

  url "https://releases.trustboris.ai/boris/v#{version}/boris-#{version}-#{arch}-#{os}.tar.gz"
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

  # Inside on_macos: a top-level macOS requirement would make the cask
  # macOS only.
  on_macos do
    depends_on macos: :monterey
  end

  binary "boris"
end
