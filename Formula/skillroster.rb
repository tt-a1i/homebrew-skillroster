class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.40.tar.gz"
  sha256 "757ca5d1112cd240fc902fcf3cb1bff645f5bb7047e87f8c18778c4e64928b74"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.40"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d7134699850bbf129c7e98c54e2960ed1a660b3bc15a6fa3075745bc0e4a63dd"
    sha256 cellar: :any,                 x86_64_linux: "8e291267270b39d4c21464f5723acd0eed5a9016cc44352f408f141be261ede1"
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
