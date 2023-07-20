require "language/node"
require "os"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.25.6-beta/zli-6.25.6-beta.tar.gz"
  sha256 "6294ea7fc8c74609be15b366fd3c3e45c61295ccfbecf3654643d9910f9a74db"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.25.6-beta"
    sha256 cellar: :any_skip_relocation, ventura:  "40c80ff25d04de3aa3b38a104a53d10a6e65bc7326ea5ffca27964f0bad4d0fd"
    sha256 cellar: :any_skip_relocation, monterey: "fd9a262cbbd31806c2405231a3190b7658cc9c83449b3e5b06b0745d19331f6a"
    sha256 cellar: :any_skip_relocation, big_sur:  "c030a8cd3813fd80e720a3f4c22d163cf331668448b59d84e11ecd8688ea6a49"
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
