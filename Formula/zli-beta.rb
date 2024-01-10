require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.0-beta/zli-6.36.0-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "7f0c9ca93d9ac73a8515cd03f2b36001c7115320de8687592e6b0f2bf9e3c33a"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.0-beta"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2ec70d55821650c480b419dbf90e58357aff837ea788b77c9f5eaf9d191664bb"
    sha256 cellar: :any_skip_relocation, monterey:       "2fcbb23e3d07887f8bf902a5fec214a7e5945bf1cfbeb2bd8951ab74c9619a17"
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
