require "language/node"
require "os"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/4.17.0/zli-4.17.0.tar.gz"
  sha256 "3e040d00b8480bfbec2baeb665eb4f138efcbda5363b6149cf982873ba8e2ed0"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git"

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
    system "zli", "config"
  end
end
