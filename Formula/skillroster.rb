class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.32.tar.gz"
  sha256 "6afb4f035f94ce49b85f55fffca9b64e9077daca52408104f9b3c20ded59a856"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.32"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "71f7a2b694161a6cd7f0f2f9d555cf5b91476ad507c506161a731c6b752d1308"
    sha256 cellar: :any,                 x86_64_linux: "f84b12cb7bb0f49d9b163591c8a22751d14844659efc0a55591cd5f0ad2c826d"
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
