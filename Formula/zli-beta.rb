require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.28.1-beta/zli-6.28.1-beta.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "58e3cd294e5f8f11cb8b45bbf94f17d718806b53cd9c27395e9713e5d679a453"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.28.1-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ebdfae7ce7a5013183686b57007699be07cdca399332aac038387ad643294b53"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e6c3be1fb96a943b59c0650fc861851130ee1ebb175b185a2a7d4ec695469089"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3e8305e6d637cbfddbf15cb8d828ccde2eed00e7fc90b6df47a47bb22c78a767"
    sha256 cellar: :any_skip_relocation, ventura:        "e656d1e0fa74a10921d5b808872e43dd1f5b298aace737db029087e187dd147b"
    sha256 cellar: :any_skip_relocation, monterey:       "730851375590415776a642a1e42f30754cd5aa0f4d9643d6340107846e4becc9"
    sha256 cellar: :any_skip_relocation, big_sur:        "e4c11b0338d042ac2427d9bc69fde5107079d4998bb7972d4bfbc266fb686f3b"
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
