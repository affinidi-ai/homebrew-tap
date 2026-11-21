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

  version "0.1.28"
  sha256 arm:          "212cfd577f3d7ac47d89a096de882dd9259e5d7e64acdfb36be11cad5ebd5966",
         intel:        "1d5c1f1f4e452bd89ce8466a17cc2fa9510c8b4019956adcb2abe8a19a930e09",
         arm64_linux:  "0768807881e4728118e6a0cf78c7ea0b0301b65e24e8d3be32a2d0430e361932",
         x86_64_linux: "64d08e8df440c4e851c430345ef2a443b7da5e8da5bb9d237587e95793e0acc6"

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
