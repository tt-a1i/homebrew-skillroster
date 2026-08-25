class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.28.tar.gz"
  sha256 "23dddf240c729eb73f8117ed1b27c17f5f2fbdb67e975e2903410b6cd618879c"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.28"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6386ef3a85f6e7355a22cf3f52fee297eb0970dc0313b93a058ec971a247b12a"
    sha256 cellar: :any,                 x86_64_linux: "5f47f165c2a81a19be3e6f273961c1f6a2730eb73ecc957efffb3c0e0b73674d"
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
