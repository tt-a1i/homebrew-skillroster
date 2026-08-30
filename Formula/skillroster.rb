class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.42.tar.gz"
  sha256 "b5bf125ab1080edfd03d03eb5353e660d569d853f2f2126b3a81d225fbc4af5a"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.42"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e7400b165a7d63ee2f8c63ed71709acf32bf85696f316a9a3f85b9b19cc8044e"
    sha256 cellar: :any,                 x86_64_linux: "78c1e00bf22453dca157a3eb2b0f9a3718d378e8cd8f2132ad0643e060fee3b8"
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
