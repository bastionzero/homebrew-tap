require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.2/zli-6.36.2.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "b77c5383b2f86ed2aecacabaec842e2cba775740e121b5022161fa3850de30b0"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.36.2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ae3533be7ba1cc411cd9b8f17a697052b08c53e3e1a3b254d4fe4e75f69a0988"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "044ae054e2b0a0238a5dac350c6141c89caedf31c7c54883146aaebbaf708cf8"
    sha256 cellar: :any_skip_relocation, ventura:        "8a4ff55706ec2ba97f920ca9a20ef10b894b2f1a530af921c80cd2a59480c913"
    sha256 cellar: :any_skip_relocation, monterey:       "9a1ad119b2262a014deb367301a688a54971ef7119e4647d53b656c8b2cbde35"
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
