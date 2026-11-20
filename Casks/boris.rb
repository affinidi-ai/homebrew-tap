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

  version "0.1.25"
  sha256 arm:          "4959d35855dbd781d5877c3f1dfa232ac425f6bbb6c4534f2aa9b5fcac29736f",
         intel:        "25eae240472ec353e0fa94561a8031959b682475f669ae61b613703bf300ddf5",
         arm64_linux:  "fc297f027dd311c6025d573533a1c65433ab3abb7219b68c0f5a90820126103b",
         x86_64_linux: "295320d643c7dbb610e2939fd36f097b058971d1cad2ebfe5f3db3aeaceda5b8"

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
