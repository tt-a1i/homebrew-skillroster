class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.45.tar.gz"
  sha256 "bd1c065cfcccc1bce5e8749864de63120e96f2757355487e857f6acf1ef4ea77"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.45"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d9a1a5091c6c81d208743a50d99b4daf4481849967254476703ca11c664155fe"
    sha256 cellar: :any,                 x86_64_linux: "f85bf30512892d5362f0f73e5cdc355d85dba91abcc67887846531d43df9e2c2"
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
