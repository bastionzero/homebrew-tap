require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.30.2/zli-6.30.2.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "1586ee1fc2e043468c92ada4510f6f193d1b3babbfebf77ceda69f9360ae19df"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.30.2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7cb709388731492df800286d29399584c2e2dd864692207dce53619433435051"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "69b38063760386942cf3fa882c77a4dba715941f17f049e0c44d2ec68802e865"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "178a60946a1ba3307674856642400fffd48247dcb9890e6984573ad3b474f85f"
    sha256 cellar: :any_skip_relocation, ventura:        "c318c9e865793db6ab7954497cafc80eadd61ab31f38ac4b78dc7fcc7e0bb9e2"
    sha256 cellar: :any_skip_relocation, monterey:       "be14bbef7e77eac3e69a79d748ab1666f94f2821aed28f01ebe89aeebdd33f1d"
    sha256 cellar: :any_skip_relocation, big_sur:        "a603276e42be87f28a4c8604d902098512374eddc0f80857ca2a3ca8b9a9d94b"
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
