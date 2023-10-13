require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.34.10-beta/zli-6.34.10-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "ece62b27cf88e4a00d743cdde6c5bce504d9f452ba218a905a1b476976a8ec08"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.34.10-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "53f1372198cfe7afe6f647872b7bd0726d4236cc149062874bff564a9b35c7db"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "83a701ec9e4f47a900d15955789735a775ee419bb902278d28a71fccfb6963a1"
    sha256 cellar: :any_skip_relocation, ventura:        "40d1120f67a04e5ba8c4a554668d76a746c055f5462c45445badf65c64a1842b"
    sha256 cellar: :any_skip_relocation, monterey:       "3cbcfb75091e7c269ca088b3fdb17706a52a7615b3cd9a97766e10fb6d453db3"
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
