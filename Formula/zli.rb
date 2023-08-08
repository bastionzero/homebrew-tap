require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.28.0/zli-6.28.0.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "5edb70b2e12182fc15e470cc7512444cfdc325c7b3ab6c50f3a4cce39165da1f"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.28.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9f387df87e7d2c434b83af5f49e0f683a22cc490743158dc278ee041e727498e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "eee7ceb78549e663ce0d781ac4913a5abb6e6f4078ce0cd646a413ff79231ba7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "87515b7f2ab61c3af0a5b4c991b963737e53b57542494b5dc3e6cdd75e37ba24"
    sha256 cellar: :any_skip_relocation, ventura:        "6c04679865bad4cc585599a44f607558512434de85b3f8c79223c38f58418c47"
    sha256 cellar: :any_skip_relocation, monterey:       "200490aad951586bd3334b49845647fa7d7d2db891c3897a963979e7f4429053"
    sha256 cellar: :any_skip_relocation, big_sur:        "1bcffd5eeed0b27c2e8eeea38e0a27801b50baa788ffae8b88833923ce547888"
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
