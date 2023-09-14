require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.33.4-beta/zli-6.33.4-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "ba1b9562d9f37ab4848c998c99e732dd895f43786b84bc74c5ffdffacdb58c31"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.33.4-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "005e4a3828cd6324a45917eaea13c28a1c94e929174e3b038916008d7df18a68"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "396c6d7b70c97b0d71c1675a21894bfca50cc4657033c1163eb0666313c75af6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "111fad4d7752a893b1ceaf46463fc085caac8f4e92b7a899ead2d789bd07683a"
    sha256 cellar: :any_skip_relocation, ventura:        "82f09cc00aa8fdd334b88e0911beadb5d4453fe8e67081ec47af9f099131417c"
    sha256 cellar: :any_skip_relocation, monterey:       "8821cb4797ea520f0f6bbe35ab347e5f96ba446d44b8696c69d1d714f57e1606"
    sha256 cellar: :any_skip_relocation, big_sur:        "96b08ecedc18a4f7136222c78f78e98ecb7027890f37343ab21e62e012491c31"
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
