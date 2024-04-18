require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.12/zli-6.36.12.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "0361dac815efbb3cb67ef903fd7941898491a10ddf6cc59b8213e9d835441cfb"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.36.12"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "45b2b8f3bbfa8750ca416f63c139f80351b3540f82825d1506e6fa410236512f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cec1f0c554499e25373a62dfc53d0e30909bba084851d1aad0e0237e74583ac3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dcf70a7efcc72c468750a79f95e414a5d3e45ef826479c12723827431aa638c7"
    sha256 cellar: :any_skip_relocation, ventura:        "7fc0674e4e69137e13abdd37c544194395dd1c20bd487e76361a7bafd19ff376"
    sha256 cellar: :any_skip_relocation, monterey:       "bc7bdd47bf11b28c2b3b9d089fa21c68a475828a29e7bd39dd4bd5257077a65a"
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
