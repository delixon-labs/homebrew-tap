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
  version "0.3.8"

  on_macos do
    on_arm do
      url "https://github.com/delixon-labs/delixon-qiloback/releases/download/v#{version}/qiloback-cli-darwin-arm64"
      sha256 "83414911b1b7ee710a8dac58ce56be5bbb501f45f3778a7d25cd658defd195fe"
    end
    # Apple Silicon (arm64) is the only macOS architecture shipped via
    # Homebrew. Intel Macs install via `pip install qiloback-cli` or the
    # npm wrapper `npm install -g @qiloback/qiloback`.
  end

  on_linux do
    on_arm do
      url "https://github.com/delixon-labs/delixon-qiloback/releases/download/v#{version}/qiloback-cli-linux-arm64"
      sha256 "df01e7f21def77115d4062bef250cebb5ecd965a8f4a309983b222675442e138"
    end
    on_intel do
      url "https://github.com/delixon-labs/delixon-qiloback/releases/download/v#{version}/qiloback-cli-linux-x64"
      sha256 "13683954e1bba84d827ec9dea4a3fb387666005543bb66c1ab38218df4fcfbe3"
    end
  end

  def install
    binary_name = case [OS.kernel_name, Hardware::CPU.arch]
                  when ["Darwin", :arm64]  then "qiloback-cli-darwin-arm64"
                  when ["Linux", :arm64]   then "qiloback-cli-linux-arm64"
                  when ["Linux", :x86_64]  then "qiloback-cli-linux-x64"
                  else
                    odie "QiloBack does not ship a Homebrew binary for this platform — install via `pip install qiloback-cli` or `npm install -g @qiloback/qiloback`."
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
