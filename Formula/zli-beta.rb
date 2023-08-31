require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.32.1-beta/zli-6.32.1-beta.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "90cd4bdb42702bc1f9a9681537d325d79da224a6557c75e12a1448e6909dfecd"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.32.1-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5cf7d4407ef1d18423d4f1de082babe70c3e301b32ef3d811207f511f55f6359"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ce443e44a5351145f2828ad05e1b75125b9243a9c69b11359b196cb43ae91920"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "75b1131b256379cdcc08b14e05a546ee67610d9f1006ca6ffffb1684007055a7"
    sha256 cellar: :any_skip_relocation, ventura:        "4eda4cd317a13e024aa2c6f83fc67329e98fb13140600c159a87df3f92bf1e87"
    sha256 cellar: :any_skip_relocation, monterey:       "a7cacf8dc9b97dba8508852a7f73d937df35307c67d323b7dfde46d1d6beaedf"
    sha256 cellar: :any_skip_relocation, big_sur:        "53f94abbfbeb3bae9876b4ebb84aa4d08ff613b59fb47575180b9047fcd426c8"
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
