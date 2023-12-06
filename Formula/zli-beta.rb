require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.35.2-beta/zli-6.35.2-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "b6b673eb69d4068a042c6c9323d1f7988f24dbfc1d0e9a209bf2e4adb0275222"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.35.2-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8b9a99d62285190c90b90062520932edf4d3a74588f1d4cc821bf765174f595a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1011982287b29241a4e12ef5af1b8c3e716a698302a9907bfb62ef595e9c3473"
    sha256 cellar: :any_skip_relocation, ventura:        "4a35c6f3b099138686957e2f2ba258c14d7e14c5a765acb6bd36b2a191f41800"
    sha256 cellar: :any_skip_relocation, monterey:       "dfcade3a5be7b0f214e273a3670fa4107046763db10f94e25a1e6b34958bab35"
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
