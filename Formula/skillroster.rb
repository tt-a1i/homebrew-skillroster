class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.47.tar.gz"
  sha256 "75e048cb7d68759aa8b5b3e3a829a24a7364a025fc92f58c78013457db09fa9d"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.47"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3df304ecaba9f4046ad18180f6afe6f1f2d02bec30e4b40b303e99c3827179d0"
    sha256 cellar: :any,                 x86_64_linux: "176e7a60ec5f890a657b2c4c4c2d300ac446e832540ffd71e0ab00693cd70dd5"
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
