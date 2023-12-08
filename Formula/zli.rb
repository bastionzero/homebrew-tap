require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.35.3/zli-6.35.3.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "85cc373747ef69e16215de50648cc5f3dac643e06b79a0ec51d9046c86e7a396"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.35.3"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f62d9754767524eeb061d3986aca7238c2f39d79443c342c8f52d04b3221b19e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0cd1b81d8c16346b3db5a23ee2f5cdde2951309125d78f45621111588eab87bf"
    sha256 cellar: :any_skip_relocation, ventura:        "d6c2f87ee706cc9dee62ca73a432eb937f42ca1562d3cd5471f5475726067586"
    sha256 cellar: :any_skip_relocation, monterey:       "efac04d1c80bad246dc8c7325cf56de701706c807e67f3f582621c6d4d65904a"
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
