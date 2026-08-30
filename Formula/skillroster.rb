class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.38.tar.gz"
  sha256 "2c741e07ad34a37cfff1fd3008f8b47d2942d4f7f2caa09b07a7703f332ab709"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.38"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e43437b327bca03c8de84b29919606abada84ba572b5982b02d33ac40ef0037b"
    sha256 cellar: :any,                 x86_64_linux: "64c22cdb7a4f96675b65347895a6030eb15ad5eccb69e38c6bc096a8d9c3f8d0"
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
