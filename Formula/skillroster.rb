class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.46.tar.gz"
  sha256 "bf4ac02bc8497f03bf5c2c2b863248d50342b2e35990cb3aeb591a59d1c662f6"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.46"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b8909705896613a920b45306be7546d73e086fd519ff10e0d7136de8ea718a6d"
    sha256 cellar: :any,                 x86_64_linux: "62a1d58ecfbe892423adee25c8eb3040f631bced9a70c990d06cab3bd3835d20"
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
