class Szr < Formula
  desc "Token-aware CLI proxy that trims noisy command output for LLM workflows"
  homepage "https://github.com/devr-tools/szr"
  license "Apache-2.0"
  version "0.21.0"
  url "https://github.com/devr-tools/szr/archive/refs/tags/v0.21.0.tar.gz"
  sha256 "2bafe7ea657a287f3a1c0844a19397bdb55f30c2bb6a31a6bb0d81a43d29dbce"
  head "https://github.com/devr-tools/szr.git", branch: "main"

  depends_on "go" => :build

  def install
    version_value = build.head? ? "HEAD" : version.to_s
    ldflags = ["-s", "-w", "-X", "main.version=#{version_value}"]

    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"szr"), "./cmd/szr"
  end

  test do
    expected_version = build.head? ? "HEAD" : version.to_s

    assert_match "szr #{expected_version}", shell_output("#{bin}/szr --version")
    assert_match "install target:", shell_output("#{bin}/szr self doctor")
  end
end
