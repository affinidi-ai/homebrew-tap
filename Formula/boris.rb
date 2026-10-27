# The boris CLI formula, for Linux only, rendered by clients/homebrew/render.sh
# for one release next to the macOS cask. The release opens one pull request
# on the tap with both; it never pushes. Each url is the immutable, versioned
# archive (a static musl binary) and each sha256 comes from the signed
# SHA256SUMS. macOS installs the cask instead: a formula's download carries no
# quarantine, so Gatekeeper would never check the Developer ID signature and
# notarization there.
#
#   brew install affinidi-ai/tap/boris          (Linux)
#   brew install --cask affinidi-ai/tap/boris   (macOS)
class Boris < Formula
  desc "Command-line client for Boris: sign in, plan and apply changes, run the tunnel"
  homepage "https://trustboris.ai/cli"
  # A formula's on_arm/on_intel may not hold url or sha256 (ComponentsOrder),
  # and brew style allows a CPU conditional in a tap for exactly this case.
  if Hardware::CPU.arm?
    url "https://releases.trustboris.ai/boris/v0.1.17/boris-0.1.17-aarch64-unknown-linux-musl.tar.gz"
    sha256 "415bdbd10a92f4de3d6530ab751d4f524b96de518ea1e4a29866100d246467f5"
  else
    url "https://releases.trustboris.ai/boris/v0.1.17/boris-0.1.17-x86_64-unknown-linux-musl.tar.gz"
    sha256 "42fab430aee90a1a26aee2bdcfe5a87678094ab6ae038dcb1a19c84f2913f489"
  end
  # No version line: brew scans it from the url, and audit rejects a
  # redundant one.
  license "Apache-2.0"

  # The signed pointer to the newest stable release, as the cask's.
  livecheck do
    url "https://releases.trustboris.ai/boris/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on :linux

  def install
    bin.install "boris"
  end

  test do
    assert_match "boris #{version} ", shell_output("#{bin}/boris --version")
  end
end
