require "language/node"
require "os"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.11.7-beta/zli-6.11.7-beta.tar.gz"
  sha256 "6d11b532a6b827fc19b325fcdc164b1fd71bfb2bc37a0f2bdfd9e1c9aaf15248"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  depends_on "go@1.17" => :build
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
