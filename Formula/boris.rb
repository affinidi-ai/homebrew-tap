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
    url "https://releases.trustboris.ai/boris/v0.1.16/boris-0.1.16-aarch64-unknown-linux-musl.tar.gz"
    sha256 "dbad133d9b434c18d895b96016a6604c827f34cef31082e6eee428d6421533c1"
  else
    url "https://releases.trustboris.ai/boris/v0.1.16/boris-0.1.16-x86_64-unknown-linux-musl.tar.gz"
    sha256 "395fa3d595d24b65f582a6bf8ec3c15c0d601fc5bafeca2b1a21b99ffe781d2d"
  end
  version "0.1.16"
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
