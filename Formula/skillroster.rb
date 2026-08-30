class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.43.tar.gz"
  sha256 "5cb385ab2a1eb63ff15aebb2c67a39bfca78bf52f1ecd505c9bccaa56d14275e"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.43"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "40527cc32a3604f4795ff3a9241cf0ff0e1d44187b4ea5ce879127e8f5686dad"
    sha256 cellar: :any,                 x86_64_linux: "bb4576bf7ead8842750994ed9d8d8107ea3ddebb8da63604eb2db70f294f2eca"
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
