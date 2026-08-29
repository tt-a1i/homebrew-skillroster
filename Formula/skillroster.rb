class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.31.tar.gz"
  sha256 "cde6f53ae9d50603bc138e35a4e373a4bcd1a1a9584832728419b539c6c6ac9e"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.31"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ef74fd693ac351db3cf138420345a8bea17bbbb28229b7e4cdc25182acfa275f"
    sha256 cellar: :any,                 x86_64_linux: "43e92071e4c3bd44ff7a0a2748b4241d033ef00501b080c300038def4161529c"
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
