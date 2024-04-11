require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.12-beta/zli-6.36.12-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "af51d48727150525ba6ee26406f49f99d914450f60f33e015bdb07975c4d5abd"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.12-beta"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2b9fd831122f22ff9fdb45287a6950112e898096facb8aaa6643f0074ad25025"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3293397e431f27e422705102258bb3bc72197330bb96205a77b4fe2e6d463b56"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2cf0eebe8a32bba430ffc01d07d72e95a1ef31aca223a9fef12a79e9ce5d2638"
    sha256 cellar: :any_skip_relocation, ventura:        "5fc72c713282be28ba7b133bc9b5e2d41ffeeac3217283e503004fdb29de2b06"
    sha256 cellar: :any_skip_relocation, monterey:       "1e8e780f4c31cee93ecef88ce86b46063df026a6c1815f8e325353c87ab777e0"
  end

  depends_on "go@1.20" => :build
  depends_on "node@20" => :build

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
