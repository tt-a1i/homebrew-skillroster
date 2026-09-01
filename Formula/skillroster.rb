class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.44.tar.gz"
  sha256 "9acbeff3d408b5acecccfcfeb45aecb1e6ab2ea3551a2776a87ca6fbb7de2a9b"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.44"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9c6611bf0ed693efc7da1fbc14b1857aa1eafbbad09ab4d210b86fcd9918ec2c"
    sha256 cellar: :any,                 x86_64_linux: "344fdbdc317926759cfd29863a3659a586ce0de4a387ec34c2a38d482dc1f6d4"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skillroster --version")

    output = shell_output(
      "#{bin}/skillroster scan --summary --json " \
      "--home #{testpath}/home --state-dir #{testpath}/state",
    )
    assert_match '"ok":true', output
    assert_match '"files_changed":false', output
  end
end
