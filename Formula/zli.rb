require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.35.1/zli-6.35.1.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "9aba69b45f17fc99d3ef6824be685991f485c9249804072ae0c3f99514dbe10f"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.35.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "713ddba3b1a3aa805f434705b5b1b2b08f12003fb24715fd327f244f550d46cd"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "156add5e7205718f47d86eee0413bb7d18453b723e1fd7ab27fe4624a466c144"
    sha256 cellar: :any_skip_relocation, ventura:        "3cdd07f5f0468f87cdcdcea2cbb888c028cfbf7446cab978f406b1db977894ef"
    sha256 cellar: :any_skip_relocation, monterey:       "87bf2a71b087c6ca0ae19930051f62c90fc7fddc35f9f4afe1341a20b4e84727"
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
