class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.33.tar.gz"
  sha256 "ccc9741a0243ca93daf0ad0c526e1d9221eface534eaa50487aae8fd19b31842"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.33"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6f8e5789f5ec72cb0966c61e62927c7c9f4cf4c364e67cb7f4ff4c3e53371353"
    sha256 cellar: :any,                 x86_64_linux: "b1272a53f33cfa3fc4b901dd3359c80d1812d957d7f667b3b630a187625a6a20"
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
