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
  version "0.1.15"
  license "Apache-2.0"

  # The signed pointer to the newest stable release, as the cask's.
  livecheck do
    url "https://releases.trustboris.ai/boris/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on :linux

  on_arm do
    url "https://releases.trustboris.ai/boris/v0.1.15/boris-0.1.15-aarch64-unknown-linux-musl.tar.gz"
    sha256 "b5a28404607367d2682a61873ba5c8ebf0d92d4eb7238c742e95ab8a4c705a8a"
  end

  on_intel do
    url "https://releases.trustboris.ai/boris/v0.1.15/boris-0.1.15-x86_64-unknown-linux-musl.tar.gz"
    sha256 "0bafce7ed30de10d4d192173cdab43bd21759c173b17337635e6f85d3a0013e5"
  end

  def install
    bin.install "boris"
  end

  test do
    assert_match "boris #{version} ", shell_output("#{bin}/boris --version")
  end
end
