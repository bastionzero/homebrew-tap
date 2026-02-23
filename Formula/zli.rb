require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.25/zli-6.36.25.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "d28c0ecfa226c45092b31467cb857df8f4e2b4554feb3dc6deaca212036aa101"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.36.25"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6da3d0eae07893214fbb56b823efb3cc33ab02605a760e22ef399ed12a090407"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b4595f19985bd4bc5e9ebdad919806dfce291f3e3a1d090b00dc003aa90b4408"
  end

  depends_on "go" => :build
  depends_on "node@20" => :build

  def install
    system "npm", "install"
    system "npm", "run", "release-prod"

    if OS.linux?
      rm "./bin/zli-macos"
      bin.install "bin/zli-linux" => "zli"
    else
      rm "./bin/zli-linux"
      bin.install "bin/zli-macos" => "zli"
    end
  end

  test do
    system "#{bin}/zli", "configure"
  end
end
