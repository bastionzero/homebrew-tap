require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.6/zli-6.36.6.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "268fdd06f26a63f89d40e44a75464a03b2bb3a9129780b40fb85b7caf7eb03be"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.36.6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e9a4444790a3dfd324c44380737365868a3eb53ece82b8362c6627a743a288aa"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d24b0387d321a349cfc9e88ebbd4bcfee58d55953175bcc8d606508e5f4cb883"
    sha256 cellar: :any_skip_relocation, ventura:        "6a65f509947eda3572194a00eacae9ca68d9f9f860d75e73f9d5de590e98d070"
    sha256 cellar: :any_skip_relocation, monterey:       "894bbc2d9200ea891413535c656a716584914aee99fdbc4900a26bbacbaad012"
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
