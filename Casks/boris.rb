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

  version "0.1.26"
  sha256 arm:          "9d3c364ea8bbfb423aa9eae09b14333d4f6d300fb7ed192c2b51f86cb59d88e0",
         intel:        "6f09bf0c402f74d578eb0b8b17e83827fe02c47598ada6f12436c7cdcb71a1da",
         arm64_linux:  "9b39befee4ea3663f4c9d6ff883e0e14c65b67bcab5a22121e2717ed97edd429",
         x86_64_linux: "70686750d35b869c531d0b8b4e72b217d14a4acbbe7a40039d00fd0465afedb1"

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
