require "language/node"
require "os"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.15.11-beta/zli-6.15.11-beta.tar.gz"
  sha256 "05d499b373d41ffe1608117a06e4863dc130a325bbd789ba3f444192a72cf0e2"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  depends_on "go@1.18" => :build
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
    system "zli-beta", "configure"
  end
end
