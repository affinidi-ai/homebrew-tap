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

  version "0.1.35"
  sha256 arm:          "5034c8bf42c723f13b2d0ba0aff860862436a5cba19b47dd640df73b2b23e9d5",
         intel:        "19d785b4b5be1b367063e41890d3c5405be94a464036c432b0e0201c504ddbfe",
         arm64_linux:  "c05085ce6aaa265ed75bf72e39d02eaf4125d110fe86edb8e3376efaf8c5bc58",
         x86_64_linux: "354fd1194a487289139e6387d5294d802d987951909af393761f2801fd564635"

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
