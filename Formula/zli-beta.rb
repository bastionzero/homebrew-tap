require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.20-beta/zli-6.36.20-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "abefb4ce3e2f5be7655da272a49b3cf995c39dae31f78acc3dc0e6176bf79643"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.20-beta"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "47458f2f7678524580500b9e4d9d2410f0a35b68b7c035748115dad38978328a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1d3e6f51a63e558c333526e0eb5faf75848e43b7957d05893cb52d598fae1f10"
    sha256 cellar: :any_skip_relocation, ventura:       "f3a612b337c599534d02b39d16a748ca1fddd5496218efca5b52a27acc229c3d"
  end

  depends_on "go@1.20" => :build
  depends_on "node@20" => :build

  def install
    system "npm", "install", *std_npm_args(prefix: false)
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
