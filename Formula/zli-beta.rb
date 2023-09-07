require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.33.0-beta/zli-6.33.0-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "64912e6226d82ee448a21a9786c2d742aa17e739d194b9bbb39c47ae88e980b0"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.33.0-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fa208c2cd8934d0d22ba150e6228b8bc6e67efe1ae7e2fb070510d5487d93719"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d9682fb7c1ef7e53c68157083bfbf5951135eee644684b5bb9324a9ec6ba6361"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a1c91033c248e1044a50173da4e982e5c2c2aeecc2f1ed5016d91c19c11b3316"
    sha256 cellar: :any_skip_relocation, ventura:        "6febdf2d0dd9fdf298bbc2478825e01706bc4b21ed7c678d59a7de26e2ba6a3f"
    sha256 cellar: :any_skip_relocation, monterey:       "c21bae87036e4ee15614dd3a8629c90be9096a2e905c3182f8192c599fe670df"
    sha256 cellar: :any_skip_relocation, big_sur:        "4b4e6376baca956a9f3e55e652f8e82db2724bf4ad64dc9374451e9570d6fed3"
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
