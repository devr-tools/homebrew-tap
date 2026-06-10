class Cleanr < Formula
  desc "AI testing SDK and CLI for CI validation"
  homepage "https://github.com/devr-tools/cleanr"
  license "Apache-2.0"
  version "0.6.0"
  url "https://github.com/devr-tools/cleanr/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "48b176223853dae0e00ee149c2bc331d43eb46c36ad917c27e6a991eba7bf2ec"
  head "https://github.com/devr-tools/cleanr.git", branch: "main"

  depends_on "go" => :build

  def install
    version_value = build.head? ? "HEAD" : version.to_s
    ldflags = ["-s", "-w", "-X", "github.com/devr-tools/cleanr/internal/cli.version=#{version_value}"]

    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"cleanr"), "./cmd/cleanr"
  end

  test do
    expected_version = build.head? ? "HEAD" : version.to_s

    assert_match "cleanr #{expected_version}", shell_output("#{bin}/cleanr version")
  end
end
