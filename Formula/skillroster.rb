class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.29.tar.gz"
  sha256 "f0b028db617e195ad2a26eecd03df1b1104ab05c6b60a421c588d03b2f0e57eb"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.29"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "481bca2cca5654224c307a1ae09635cfdd6d1df6a1fd10309e743f67d7e6518a"
    sha256 cellar: :any,                 x86_64_linux: "133689963da343b23f9177eda73f802dba885265ff6675c5ee1cae897ca04e30"
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
