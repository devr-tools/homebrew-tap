class Merger < Formula
  desc "Mutation control plane CLI for AI-native engineering"
  homepage "https://github.com/devr-tools/merger"
  license "Apache-2.0"
  version "1.1.0"
  url "https://github.com/devr-tools/merger/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "fecfb9d391c4d7828d5e7346bb6d42d20a3ea768868b84d5f4fb68e87a845c53"
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
