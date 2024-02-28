require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.6-beta/zli-6.36.6-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "efa200f8db0a05fb0940e3f22c2742028a800c3a1c3cf256cbe0f8405f3b7023"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.6-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "17750e77dd5e005c795e506b5c898731c3e6865de5ed798e38dc5e759ea460f2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0b200df6b6470aa1489f3cad6a538ccac8126a0ec2d2c0bfa3620ed542409b1b"
    sha256 cellar: :any_skip_relocation, ventura:        "38974c2bd45545f4b6a57f2d0a214b237edcb279f1ed8252c6fde1d409204636"
    sha256 cellar: :any_skip_relocation, monterey:       "e9969093d65e5942274a611aa12da94c37352c5058d276c1ea3c687e20b67e6b"
  end

  depends_on "go@1.20" => :build
  depends_on "node@20"

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
