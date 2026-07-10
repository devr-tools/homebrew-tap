class Merger < Formula
  desc "Mutation control plane CLI for AI-native engineering"
  homepage "https://github.com/devr-tools/merger"
  license "Apache-2.0"
  version "1.0.0"
  url "https://github.com/devr-tools/merger/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "bc6290a6e05f0d94e7d9fab7e91099c5d711efe6e4540ca5bea6bc4c9eea4c0a"
  head "https://github.com/devr-tools/merger.git", branch: "main"

  depends_on "go" => :build

  def install
    version_value = build.head? ? "HEAD" : version.to_s
    ldflags = ["-s", "-w", "-X", "github.com/devr-tools/merger/internal/version.Number=#{version_value}"]

    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"merger"), "./cmd/merger"
  end

  test do
    expected_version = build.head? ? "HEAD" : version.to_s

    assert_match expected_version, shell_output("#{bin}/merger version")
  end
end
