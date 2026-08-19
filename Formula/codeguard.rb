class Codeguard < Formula
  desc "Repository policy and AI code review CLI for CI"
  homepage "https://github.com/devr-tools/codeguard"
  url "https://github.com/devr-tools/codeguard/archive/refs/tags/v1.5.4.tar.gz"
  sha256 "375d0cee7ea71f01688ced391d54ec83915017665225b8d42cae6e552b101076"
  version "1.5.4"
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
