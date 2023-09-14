require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.33.4/zli-6.33.4.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "2dacee31ff4acc169d9f6436519407e5aabd37cbf6ba674412f57124eabb6cb2"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.33.4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "32bda053b06eb6a91dc8b66896e8125c659270dc051786b2eca0311e91c26dbc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4fd2f1bc91f062fbca27ebd8bf517bccca4549a5a973a9b6dd6dfcc440032ca7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3ba93436dc93de901ef23a418bce5c68bffbd90f72af0150251a01de673b869e"
    sha256 cellar: :any_skip_relocation, ventura:        "b5456caec365e28a63eb9a7adf199b6d30a854dce723ec6433f4ced4c1aef5e3"
    sha256 cellar: :any_skip_relocation, monterey:       "27588adb1f6c4a0ddcb4d1e974a1c2130787cf21e97d52d2325cd92bde60f233"
    sha256 cellar: :any_skip_relocation, big_sur:        "d47cd2e9390b0fa987f1590103cd770b17fb5ea9c83d9a971d1b6e7c4e4043f4"
  end

  depends_on "go@1.20" => :build
  depends_on "node@14"

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
