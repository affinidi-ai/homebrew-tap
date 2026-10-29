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

  version "0.1.19"
  sha256 arm:          "6b3b907afa73415cd5bdf1ad87946dbb74ac9d54382610072f505e89608bec08",
         intel:        "6dbdbfa0332e0a44397ad08684e895f04fc2469e3525738d9b1351a4401c897d",
         arm64_linux:  "57a93c3de2b314680716f71b2c2c6a861d1afc4f4e329c7b36cbbc3be40c76cd",
         x86_64_linux: "eb60d230881b383f5049d5a2e563cdd2f10bac88a3f1b5f95042a02ad1b20157"

  # Inside on_macos: a top-level macOS requirement would make the cask
  # macOS only. Homebrew's stanza order puts on_* blocks here, before url.
  on_macos do
    depends_on macos: :monterey
  end

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

  binary "boris"
end
