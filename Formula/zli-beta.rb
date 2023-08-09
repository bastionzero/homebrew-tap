require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.28.0-beta/zli-6.28.0-beta.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "ff5d646a2327756c078a0094642741a70edecde4144aa702656edb2249fb03b5"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.28.0-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "afa2628a2d5a1b887267d01e8e275a0b10381ef1b611968c8209c0f8ede0000c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e74d4f6106dc7e5b2df2a22eeefee69a3251c368bf02781871a57c9620ad7f59"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7515e60edf1cde2c16aa1f04e674bfe6b794dcdce7848843b2e5d5be8fb45ae0"
    sha256 cellar: :any_skip_relocation, ventura:        "a8545faebb0ff0dfc4c6f53805da231dbe666fc3c0f8add194087f4c4bcffd2c"
    sha256 cellar: :any_skip_relocation, monterey:       "cad140bb587e55f6417cf7fc1007a074b3ebf6890e1ae0c36a6265b62370e19e"
    sha256 cellar: :any_skip_relocation, big_sur:        "a3491fe75154ed8d51dfd9242bb574c6658377bda3223ffafc4518f18c3d75ca"
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
