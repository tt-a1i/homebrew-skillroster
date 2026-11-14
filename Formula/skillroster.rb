class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "4deac30a8cbf0fafc9cd2a502bf472c72a60e818560c0a9990762f1a071bd360"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.9.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "345dbd036f56b29f51259bb0ddd5c38c5b579fbe0fdfc18ba213b01c931b3742"
    sha256 cellar: :any,                 x86_64_linux: "af8006baeef95c3b46f39f4eb70cbbc9e542f77652fc22e07a16ff9fe627b93c"
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
