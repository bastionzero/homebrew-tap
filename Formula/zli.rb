require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.28.1/zli-6.28.1.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "010290c8248ee603d147d74847434c8cb7138aaba2c529c0887b17162b5cb23b"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.28.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8a4390ee49cc0e737e7dc7010c96159a4857eedad4a7c45b74b15a98383b95ec"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9aa567399fa8c98606272b0df26712bb6f2e32f20bbec000eba53f5b3c374851"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e8792c42de4f1781115b2bb325f26786e906351482d6c9c297013088bd5f3298"
    sha256 cellar: :any_skip_relocation, ventura:        "1cdbaeb190571e36dc29047ac46c6430e3a3d841874471dbbc9fc27a44ab9963"
    sha256 cellar: :any_skip_relocation, monterey:       "42975b3a1e606592b72fdac0c0b09d59dc8dc5f46780f39c17b0c62f0e12174f"
    sha256 cellar: :any_skip_relocation, big_sur:        "eb7bedaad4958484ed8868349f07e0a840934b67f17d8923cb436259b5fc1a08"
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
