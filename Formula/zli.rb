require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.32.1/zli-6.32.1.tar.gz",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "bcd64d72a493829601ee73e1c28966a50d4c8a2e5f0db4c4bc965ff8aceaf548"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.32.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f95503abb8e476ffbe876e8ca3c55f1252bb1ace5dff77f81fe01d8401af1687"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5b550a267cd1c21d6fe6aae36ef0f87311a0181e1b533c85ad1a6a15d590c574"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "55423aee4e86ea769d1ceee354d0b17776e2be26deba831936f22fe06cda5842"
    sha256 cellar: :any_skip_relocation, ventura:        "6fe1b512fa432c482ca0c999e0a3524d796548b5fb798a056d2d6a448c472fc4"
    sha256 cellar: :any_skip_relocation, monterey:       "8aea1db4a8d819279e867089100fab6a575ccff936a751a98619baef8f322419"
    sha256 cellar: :any_skip_relocation, big_sur:        "85830cc9c819a22ff6c74c79759dad08753c9fbfe4061e1ba5740c61347b8654"
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
