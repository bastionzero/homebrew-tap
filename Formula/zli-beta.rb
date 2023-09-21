require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.34.1-beta/zli-6.34.1-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "50db895f1b8271d61c454d3463a10bf2b3b3156476f3ba42189fc28b0b031a0c"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.34.1-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "abe1a02de3a90ccc68bccede1f659c799ddd2ea708f8508f3d4cdf176ab75e7d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4a1f9fa54fb8b6a8572b67b96b9fb57569909baf4e10560e844567da5afac00e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "28417f37ff22f31e57d402882ae4ae5c72c304186f13e75c669bc421caa6fac1"
    sha256 cellar: :any_skip_relocation, ventura:        "1dabe6cd20d39184b9e2f192377b1408c7aa9c61d0392a10c18faaa5df6c42fb"
    sha256 cellar: :any_skip_relocation, monterey:       "ed13bf0ffa1e2f9b063801cc614a308aa93a9af40e4ba21b2d59c9047a605cac"
    sha256 cellar: :any_skip_relocation, big_sur:        "e95c3e67726a7a584725e9471bd82237cc8cde681dce7f360510b8c467c827f9"
  end

  depends_on "go@1.20" => :build
  depends_on "node@14"

  def install
    system "npm", "install", *Language::Node.local_npm_install_args
    system "npm", "run", "release-prod"

    if OS.linux?
      rm "./bin/zli-macos"
      bin.install "bin/zli-linux" => "zli-beta"
    else
      rm "./bin/zli-linux"
      bin.install "bin/zli-macos" => "zli-beta"
    end
  end

  test do
    system "#{bin}/zli-beta", "configure"
  end
end
