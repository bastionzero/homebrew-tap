require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBetaAT6302 < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.30.2-beta/zli-6.30.2-beta.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "c8ce07daefa911affe9cc1ce6b93d0031041a3b1da60e5bfe2e039b3f90c6bbb"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.30.2-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3eef7eb151fe3062b27943507bf76c6b3ccf73ea560556d00f035663fa35227b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "589a17b927d4752be812ac3780237868ff7ddddf9376fe91f823fc6dc2bb0c93"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ca3dea07631b7bd790d27fc06577cca68a8018751998f82fc85fb4a594c8c505"
    sha256 cellar: :any_skip_relocation, ventura:        "ed1c2e9e467552b93c575b4a9f7ff28e05b8592499d9d8f9b51488cf0eca7b46"
    sha256 cellar: :any_skip_relocation, monterey:       "113c3b31f19f67c683739c6c50dadcb5633cca1dd39695991e2acd80507017e9"
    sha256 cellar: :any_skip_relocation, big_sur:        "486a350bffc7cb97643d445411921f1e849c8fae31dd1d60b68a9061f06b0513"
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
