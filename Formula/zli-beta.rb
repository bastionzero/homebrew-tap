require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.27.4-beta/zli-6.27.4-beta.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "c61c9cfcd82cc9f38b42b308b4c111925aa1755adcf709c56bd9f13252f88678"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.27.4-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b2bf6057cd71cc7fca61556e525dae98a71ba7893a333061a998540041eeed15"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8b7aba0c92982e43a8da4060701b0f7c3538146eb956d22823d4581bc056bd5e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a560d6c833fbe4b033b787cc3188da28665210145dab5ce32e67464499ed7737"
    sha256 cellar: :any_skip_relocation, ventura:        "c039fe0bc17c2d2dcbb801a80ddadf2a8e55a7e5935a2c50f1d51001f7cef8d4"
    sha256 cellar: :any_skip_relocation, monterey:       "4ceb3935eb95dbdabf63c3f136c2d3e5090ca8ab0daed75af3222b81882e1e2b"
    sha256 cellar: :any_skip_relocation, big_sur:        "90709b0be4ee2d73f102851c5fe64bb9f8ef6cefab38d1eb0a5c5e654c8ecde0"
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
