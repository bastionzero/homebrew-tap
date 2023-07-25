require "language/node"
require "os"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.25.8/zli-6.25.8.tar.gz"
  sha256 "62ae753cff2ebca5fc197110356f01cdd840b081c9e32edfd23073f5917196f6"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.25.8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c4fca7aeb47664b52ebdbef5444fd7f7a2a29be36659c808d1ef2a695e91a705"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "44bf816c8d06dd398039cb9c12c527d325559c11b0389ac0a86d7b24e6299b62"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b8e7e029c9ee391a610167d1edbd728d845f686b3902d4d447981105a7bfb0d2"
    sha256 cellar: :any_skip_relocation, ventura:        "c234147f7d39cd56772bec0d9e2ecdd362d8769fa5c72d5d2d597b40f71c367a"
    sha256 cellar: :any_skip_relocation, monterey:       "04425fb7ebdbfee0702f6ebfd4180d115c968b95affd1e9d5f022ce498164d49"
    sha256 cellar: :any_skip_relocation, big_sur:        "73f9bab9c1a9b349c3f62d75798da25eac3f4dfaca703da7fe8db67522d3cc3e"
  end

  depends_on "go@1.20" => :build
  depends_on "node@14"

  def install
    system "npm", "install", *Language::Node.local_npm_install_args
    system "npm", "run", "release-prod"

    if OS.linux?
      rm "./bin/zli-macos"
      bin.install "bin/zli-linux" => "zli"
    else
      rm "./bin/zli-linux"
      bin.install "bin/zli-macos" => "zli"
    end
  end

  test do
    system "#{bin}/zli", "configure"
  end
end
