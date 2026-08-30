class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.41.tar.gz"
  sha256 "b2416c5311af7bb3c40081cae5c8760f8458253ce15c98e4e1bf8a40e490e97a"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.41"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cf0235c43f5a8c7701bbcc2f1cfe75da8b74702767445ef5a79eefb9b67a206c"
    sha256 cellar: :any,                 x86_64_linux: "493d57bb958928c6af4ff89dac40fd951fbde9c807c65d675b9fe28eedd2db73"
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
