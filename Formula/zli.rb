require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.34.10/zli-6.34.10.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "27533fa6c4cb7f80604c12964d54d8246b95319a4753415d5b3a4a643d77a074"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.34.10"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "06cfb9f66d2b14832edc2fc0dd39086a0bb3f893daa409b018440a0f8540bc92"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bb3a43a4e354271587ad29352bf1ac78388703ec158ac8016baea44395942c7b"
    sha256 cellar: :any_skip_relocation, ventura:        "9420b12c0797783e738449d1630b909fec180fcf70c75046bd88cba49c49dd50"
    sha256 cellar: :any_skip_relocation, monterey:       "6d6b171e58609f54da49c75d72294da24694ee64c5bc39df77ae94003088f7f3"
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
