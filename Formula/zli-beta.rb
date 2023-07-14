require "language/node"
require "os"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.25.3-beta/zli-6.25.3-beta.tar.gz"
  sha256 "dd957afd5c6cccc57d00ff9edec0e5f434acfb4222f5a746dd99784ae071ca6d"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

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
