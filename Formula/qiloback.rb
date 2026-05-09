# Placeholder formula — populated by the
# release-package-managers.yaml workflow on the first v*.*.* tag.
#
# This stub exists so `brew tap delixon-labs/tap` does not error
# out before the first release lands. The real formula carries
# version + sha256 + url(s) per platform; the workflow rewrites
# this file end-to-end on every release.

class Qiloback < Formula
  desc "QiloBack — backend manufacturer CLI (placeholder, awaiting v0.3.0 release)"
  homepage "https://qiloback.dev"
  version "0.0.0"
  license "FSL-1.1-ALv2"

  def install
    odie <<~EOS
      QiloBack has not been released to this tap yet. Wait for the
      first v*.*.* tag on github.com/delixon-labs/qiloback-core to
      land, then `brew update && brew install qiloback`.
    EOS
  end
end
