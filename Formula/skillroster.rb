class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.39.tar.gz"
  sha256 "3f30cb6b1f9e42abdcf82ad87dfc8f4afa4985e59cb1b2b5806fc2912104b56c"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.39"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1512732b61d49050fe1c8b29b95b9cfae36c4c8a2a04ec709bfd20f8e9ec167a"
    sha256 cellar: :any,                 x86_64_linux: "3f3e2bd606a7464c5f7cc271df58e96c331077c267fdfec840ff62ddc88b0a2d"
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
