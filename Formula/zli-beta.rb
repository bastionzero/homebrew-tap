require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.34.2-beta/zli-6.34.2-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "ba1e7296ab259868040a88269a947aff9fbeceb54e3ff0d339635914516e3e34"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.34.2-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c634d0b83b0bf0bb1d40a0957638816ee9e3f9dd1ca7628197d1dbd328c1a230"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d8ff1e7346b1f3b8dd43bfd601869d369059cb4c8238097190dbd38b11d56e28"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "41eb8c71d0d04a8346b2e7aa09a7b0a7d82b98573b2ef4ebd6ad7dbecd7b99c5"
    sha256 cellar: :any_skip_relocation, ventura:        "88d4da3ac79a4ebe80f397d0b0c6f1c12ac90291284540f26e9ad4ae2f0af5ab"
    sha256 cellar: :any_skip_relocation, monterey:       "a76c4bf848a55335ee278a2917e338a852fc3fa29d68d24d29b53dab09619036"
    sha256 cellar: :any_skip_relocation, big_sur:        "1553458a2e46b5161361a28553e60eceaf7cff1a6b2c4dd681035fbbba2f981e"
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
