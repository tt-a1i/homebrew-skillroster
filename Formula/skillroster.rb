class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.48.tar.gz"
  sha256 "fb002a2c885ccf5f58b6d84724f0dc23079372f23f6ff0fb55a46455fe1570e9"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.48"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4f3f21da054ca4d6443e60f69c46c6b3fa7796c1a8fe53f66a781a14b86033b5"
    sha256 cellar: :any,                 x86_64_linux: "152ef4d7e705dbc826a2efad2dc409b80aaed0b9246b20afe5180d0ba024ac92"
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
