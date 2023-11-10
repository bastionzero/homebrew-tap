require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.35.1-beta/zli-6.35.1-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "1a305d2b529ee654b585d553cd92e7bcce99c849c7f12a4cb12d3ac20e5a6e09"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.35.1-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "21af42758a32d2c7d557fedd2c6277d83ca81d4f184ae08c4a799bb09e130960"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "322fa949ab77684cb644e9ada040b404cd5ee98d553f789dd147b812f187906e"
    sha256 cellar: :any_skip_relocation, ventura:        "951803645e000a96285262396729aea186095598cdf8e7132fae3de7ab637f0a"
    sha256 cellar: :any_skip_relocation, monterey:       "d21c5a4ec3799621d49ad0d3f2e2a0fbbb09af8fa9628e4c3b41ead3a5424129"
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
