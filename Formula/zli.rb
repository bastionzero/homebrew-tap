require "language/node"
require "os"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/5.1.0/zli-5.1.0.tar.gz"
  sha256 "d11847932df5231de17d6cd7bd1651edaa8bc3b9fe513fa31d0bcdb90a8f3821"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git"

  depends_on "go@1.17" => :build
  depends_on "node@12"

  def install
    system "npm", "install", *Language::Node.local_npm_install_args
    system "npm", "run", "release"
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
