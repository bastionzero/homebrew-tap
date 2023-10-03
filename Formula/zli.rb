require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.34.2/zli-6.34.2.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "57a9572afb7a17f6202827b287f9bf570051c02ea4942e91083671e219bb6026"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.34.2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4dc66ec8e8b7b20621ef5af36eeea84c4c6daafeea37d73065121e6866fa7475"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "97682368a43b4fe997ee9461a41bd1965b4698fc9340765c9659e3852dac28e9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e27f353bcdae9435cebf1fc128106313fd2e3ae10c206a27e37091b7b58feff4"
    sha256 cellar: :any_skip_relocation, ventura:        "a958ceb6d31eba2756243d0679815dcaadfe8c056b0dbb0ccd6309f88fc8232f"
    sha256 cellar: :any_skip_relocation, monterey:       "6eff1e5d461ae1c5c6c8d8f71195f79eb8ca01826f9ad6b418428a2b9bf7b167"
    sha256 cellar: :any_skip_relocation, big_sur:        "2aba3a811c717661b6b9751d56e7e8ca2d27d3e8488b58197c1424ea612d2175"
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
