class Skillroster < Formula
  desc "Local skill governance for AI agents"
  homepage "https://github.com/tt-a1i/skillroster"
  url "https://github.com/tt-a1i/skillroster/archive/refs/tags/v1.8.30.tar.gz"
  sha256 "30c0fbdf4c2aa479d138be5caf73be2f882aa8fde2664445e813ed4e51f8d72e"
  license "Apache-2.0"
  head "https://github.com/tt-a1i/skillroster.git", branch: "main"

  bottle do
    root_url "https://github.com/tt-a1i/homebrew-skillroster/releases/download/skillroster-1.8.30"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9bfc5368c925877c39959efdce4b5dfae06f8a3da68ab8fdb0ab35d412745ab5"
    sha256 cellar: :any,                 x86_64_linux: "729a8be3ec665e22bd12ee2ed9dc0442b785f52d75f1f3c6c22466ae9f2c06a9"
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
