class Cleanr < Formula
  desc "AI testing SDK and CLI for CI validation"
  homepage "https://github.com/devr-tools/cleanr"
  license "Apache-2.0"
  version "0.8.1"
  url "https://github.com/devr-tools/cleanr/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "2c931956132becb95c0b590f9adf750378b395eb4abfd52dbd9b9b56565bea74"
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
