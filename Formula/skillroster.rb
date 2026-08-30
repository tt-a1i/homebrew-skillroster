class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.36.tar.gz"
  sha256 "973bd9113cfc1cc5b0ecf75403dd375789af365c7ffe8045fe1f79ad69f82bcc"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.36"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f17ae58187e2e52ccc6da89b7acb8f469fd56ef7dd57b739de8d2545d62fb0fc"
    sha256 cellar: :any,                 x86_64_linux: "72bc9854246f06b1e688a8670aa287bd3411dc5048842cdb2a433f924c4296e5"
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
