require "language/node"
require "os"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/5.1.50/zli-5.1.50.tar.gz"
  sha256 "6125b313c54655bc4bca2ffdb6ee96b77f2825262ebcca8ce3f6f7cc900e5905"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git"

  depends_on "go@1.17" => :build
  depends_on "node@14"

  def install
    system "npm", "install", *Language::Node.local_npm_install_args
    system "npm", "run", "release-prod"
    rm "./bin/zli-win.exe"

    if OS.linux?
      rm "./bin/zli-macos"
      bin.install "bin/zli-linux" => "zli"
    else
      rm "./bin/zli-linux"
      bin.install "bin/zli-macos" => "zli"
    end
  end

  test do
    system "zli", "configure"
  end
end
