class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.9.1.tar.gz"
  sha256 "c3d4c6631cfd7c3d4282acbce45aec64888401eb3855809d6e4c31289c19e32d"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.9.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a845436c7ba116b0f815ead8fde2083ce1c4460f9169ba3953b12df25683a1f6"
    sha256 cellar: :any,                 x86_64_linux: "43252d40c25d12a313c38dae27840824f5e2f48f75e0f5543dd0fac4bd97c3a5"
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
