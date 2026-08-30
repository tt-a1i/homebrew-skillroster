class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.37.tar.gz"
  sha256 "bffcb4435029b378c3ddf3332890fcfbfa55dd912fa6893b2e09859e139e0e02"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.37"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "db495039f5140b67221ec2ee8d6b96f156812820b6563ce5e6b64b6036277ed7"
    sha256 cellar: :any,                 x86_64_linux: "b568b793c1a73856e52b804de2f675e2cc72498a348390b018b0d123787a9a32"
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
