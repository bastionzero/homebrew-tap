require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.16/zli-6.36.16.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "204ef4ec7634924f37798c96531dfea3d3ea0fd3d8cd9d73823cda998b9ea2b7"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.36.16"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "accfc4d17c9a23b983cf15db8c72c9e1846d7669cc5b68a2268ba8d73374047a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fcf811e4339285f3e7a317d43261e73baa5d60b192e8f623fbddbb958d15efea"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3de3075c60b8c7797b4e9d018337d15bde4817843ca0fd17607949f410273624"
    sha256 cellar: :any_skip_relocation, ventura:        "5764fe2491c25a76d27cc7de1470bfa03fc18c464cad6b444fb679cb6638877f"
    sha256 cellar: :any_skip_relocation, monterey:       "57c48a1f8cbead9ba17b0e2864450ea9fdea5d2c82afceeaa934e7a533a6df27"
  end

  depends_on "go@1.20" => :build
  depends_on "node@20" => :build

  def install
    system "npm", "install", *Language::Node.local_npm_install_args
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
