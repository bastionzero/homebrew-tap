require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.27.3-beta/zli-6.27.3-beta.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "c3eda94e50b20ee238a441d3fa25d6e540fca25cd104120c39db0671e87d1c1e"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.27.3-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "812420ecf466b833880256d7d3fe231231fa992a8984c4e5727ff8db40a57e7f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bd72b2599ea0aecc3485ef1a51a89a717af199161f320af86cc8ca3169c316c2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a5035f86dfc9030112a136f14ef72f9d47ddbe29e0e2569c73d77bab62bd0e04"
    sha256 cellar: :any_skip_relocation, ventura:        "cd69a0fc18d90d4385931b72d96013cae527c4790641398777dc2a323b434caa"
    sha256 cellar: :any_skip_relocation, monterey:       "12f9c88f401328976ab2760873c0bc11c0c958c4190644acd431b3f15c482ceb"
    sha256 cellar: :any_skip_relocation, big_sur:        "964bb6278b52fea4110f0dd203b120165b2e074661a16c04cd4ed49397ffd0f9"
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
