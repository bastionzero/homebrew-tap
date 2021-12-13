require "language/node"
require "os"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/5.2.5-beta/zli-5.2.5-beta.tar.gz"
  sha256 "9b89aa820ea64e0b4f8266acf6ca85a07df12f45caebf6c8349028518804bbd9"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-5.2.5-beta"
    sha256 cellar: :any_skip_relocation, big_sur: "9be8576938c42353064d21c686ac7a009d4d9ff3b790e47e94c16284f13a5e8e"
  end

  depends_on "go@1.17" => :build
  depends_on "node@14"

  def install
    system "npm", "install", *Language::Node.local_npm_install_args
    system "npm", "run", "release-prod"
    rm "./bin/zli-win.exe"

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
