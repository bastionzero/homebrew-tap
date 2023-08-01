require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.27.0-beta/zli-6.27.0-beta.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "5fe26009ecfdf2c2f2f4f7b9b99b6430247c2b1ee5fdca1a5e883e27a035fa8b"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.27.0-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "814c4f0e110fe98fb47a41c069376daa283f2904a827b9b334fb48ec68588195"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e804ade9367bb2213e4e34669e907fe09ba88b330b575cd68d4486177d7cbb89"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "390132220d694abcae8a0f8f5fbc168f798e49ae0577c79ac44ebe5564c21e62"
    sha256 cellar: :any_skip_relocation, ventura:        "b737cca94e5d03409ad2597533ba8a1db78cae282c152a207e4815f068349e1a"
    sha256 cellar: :any_skip_relocation, monterey:       "c23db969c29fee25ccaa1ae5dda89f21de41e17b99a73571957026d3a63b1e4d"
    sha256 cellar: :any_skip_relocation, big_sur:        "87c8c05b52e27498522469e84b5a3acdf676866f47589e7b60219f4e9bc7d783"
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
