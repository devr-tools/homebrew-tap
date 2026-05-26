class Cleanr < Formula
  desc "AI testing SDK and CLI for CI validation"
  homepage "https://github.com/devr-tools/cleanr"
  license "Apache-2.0"
  head "https://github.com/devr-tools/cleanr.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = ["-s", "-w", "-X", "github.com/devr-tools/cleanr/internal/cli.version=HEAD"]

    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"cleanr"), "./cmd/cleanr"
  end

  test do
    assert_match "HEAD", shell_output("#{bin}/cleanr version")
  end
end
