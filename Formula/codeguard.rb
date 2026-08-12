class Codeguard < Formula
  desc "Repository policy and AI code review CLI for CI"
  homepage "https://github.com/devr-tools/codeguard"
  url "https://github.com/devr-tools/codeguard/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "ba4642fcab9054d0b2ed8ea180e7a21f618b6f8cdd90f41bd91ae32f445cf45b"
  version "1.4.1"
  license "Apache-2.0"
  head "https://github.com/devr-tools/codeguard.git", branch: "main"

  depends_on "go" => :build

  def install
    version_value = build.head? ? "HEAD" : "v#{version}"
    ldflags = [
      "-s",
      "-w",
      "-X",
      "github.com/devr-tools/codeguard/internal/version.Number=#{version_value}",
    ]

    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"codeguard"), "./cmd/codeguard"
  end

  test do
    expected_version = build.head? ? "HEAD" : version.to_s

    assert_match expected_version, shell_output("#{bin}/codeguard version")
  end
end
