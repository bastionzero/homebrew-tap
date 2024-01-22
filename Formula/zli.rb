require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.3/zli-6.36.3.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "0668d9de8e78bb2dfe78fcd5f2b2104865a621aa76a41a846bcd0020a8d631c8"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.36.3"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6eeab409e429d6f49b28a0fae53878be24388178cc598d27604ba8eb0db31071"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e49de12b4c42265c78f966c9d10974a83b0e2b885921b7db5848888c5a4d4225"
    sha256 cellar: :any_skip_relocation, ventura:        "3e968dc1ae34ff06d628b9e810fd2cbfc62d8ea5c8606a10e642f6de7aac35b0"
    sha256 cellar: :any_skip_relocation, monterey:       "64feaa4ce3206b6c8d35e57ef45d0ee94762da2fcef6bb2257277d9ce4d21885"
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
