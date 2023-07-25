require "language/node"
require "os"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.25.8-beta/zli-6.25.8-beta.tar.gz"
  sha256 "221fd949a5ba97560f126b503de341cd3de692742347c6bd0b624f3471b9cdea"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.25.8-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cb311ab8ee271770fe4b3aad0dda7f0952407f9fc31f61bd4a9ce2c1d508d295"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "82cfe6ce7355c3d5bac8c2da10be423114b164272b5bf441868e78f0a62f2aba"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e1f7f88aed5c2d436e561f98c6b2fe1db18c692319dbd871b2abec3e345daf94"
    sha256 cellar: :any_skip_relocation, ventura:        "33f52623b083036790ff2bf930844a3278f364041166a9fd7f2c365364bd53c2"
    sha256 cellar: :any_skip_relocation, monterey:       "5a38f5d172469fe8d0e1232ab7d6430984de34ccca8330f438b9bcd694c7daa9"
    sha256 cellar: :any_skip_relocation, big_sur:        "1aedea3c835d87aec731258dd3124abe4bce29b54f1c584859dd4c301e7eadea"
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
