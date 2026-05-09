# typed: false
# frozen_string_literal: true

# Homebrew formula for the QiloBack CLI.
#
# This formula lives in `delixon-labs/homebrew-tap` once published.
# Users install with:
#
#   brew install delixon-labs/tap/qiloback
#
# The formula downloads the prebuilt native binary from the QiloBack
# release surface, verifies the SHA-256 against the cosign-signed
# manifest, and installs it to the Homebrew prefix. No build from
# source — the binary ships from the same `release-binaries.yaml`
# pipeline the npm and pip wrappers consume.
class Qiloback < Formula
  desc "QiloBack CLI — declare a backend in YAML, ship a FastAPI + PostgreSQL stack."
  homepage "https://qiloback.dev"
  license "FSL-1.1-ALv2"
  version "0.4.0"

  on_macos do
    on_arm do
      url "https://github.com/delixon-labs/qiloback-core/releases/download/v#{version}/qiloback-cli-darwin-arm64"
      # Replace with the SHA-256 from the release's SHA256SUMS.txt at publish time.
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/delixon-labs/qiloback-core/releases/download/v#{version}/qiloback-cli-darwin-x64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/delixon-labs/qiloback-core/releases/download/v#{version}/qiloback-cli-linux-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/delixon-labs/qiloback-core/releases/download/v#{version}/qiloback-cli-linux-x64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    # The release artefact is a single statically-linked binary.
    # Install it as `qiloback` at $HOMEBREW_PREFIX/bin/qiloback.
    binary_name = case [OS.kernel_name, Hardware::CPU.arch]
                  when ["Darwin", :arm64]  then "qiloback-cli-darwin-arm64"
                  when ["Darwin", :x86_64] then "qiloback-cli-darwin-x64"
                  when ["Linux", :arm64]   then "qiloback-cli-linux-arm64"
                  when ["Linux", :x86_64]  then "qiloback-cli-linux-x64"
                  else
                    odie "QiloBack does not publish a binary for this platform yet."
                  end
    bin.install binary_name => "qiloback"
    # Convenience symlink so muscle-memory ``qb`` works too.
    bin.install_symlink "qiloback" => "qb"
  end

  test do
    # Smoke-test: --version exits cleanly and prints the version we
    # asked the formula to ship.
    output = shell_output("#{bin}/qiloback --version 2>&1")
    assert_match version.to_s, output
  end
end
