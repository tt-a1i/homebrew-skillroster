class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.35.tar.gz"
  sha256 "d032f683081a103fba379396465d02a5280bfd523a1a2600a64e3586fd7d9334"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.35"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "58924df4b2135196bdab0a1abb86ba73d927ad7ced87a11014918bb50d81dbfe"
    sha256 cellar: :any,                 x86_64_linux: "039bfffeb6694068e6d27d4464202e642217004569a26f767cf87c349e5b909f"
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
