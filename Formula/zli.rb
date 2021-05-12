require "language/node"
require "os"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "url "https://github.com/bastionzero/zli/releases/download/4.17.0/zli-4.17.0.tar.gz""
  sha256 "a1578c008183156a5ba8d75f71850b3f347725abaf846bc8e62cee4c585b431b"
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
