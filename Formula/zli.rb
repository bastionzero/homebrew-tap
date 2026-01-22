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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8199c36c7d3b6736e929400733c8598a87e5b8c0c4043bb0731f70468b5a339c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3e751f5828923854114e709629eb687509dbaf95aa05a4b96825b84867e5846c"
  end

  depends_on "go@1.20" => :build
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
