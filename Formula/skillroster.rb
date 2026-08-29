class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.34.tar.gz"
  sha256 "b4648ef84125bbb18bc1455d23a2483ed7a5ed44d8d40152198fa243703378d6"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.34"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "55602a66c8ae05f9f3b36163831bb047821e62a140054a7857ce7925a0181ad8"
    sha256 cellar: :any,                 x86_64_linux: "d47197b9dee091757821c01053490ed5a224985ba035e5a053425926a6a495ed"
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
