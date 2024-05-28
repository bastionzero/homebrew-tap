require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.16-beta/zli-6.36.16-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "f6a424d738344de8499036d514436477d6aa9fba8081066f3afff86b408c3750"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.16-beta"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "0bd87e63a8888c2fa28a4e2c90a2b0727e0a39ae9805ce00f2bbf49b4657a543"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5b75186efb107fd03ec60881ae9125ee7bad95f5a56eb1844a5e6a107f617677"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e236e8b772e66e7683d416f7ab791a4df83a59ae7f5fffb503ac69aac261fc33"
    sha256 cellar: :any_skip_relocation, ventura:        "08dc2a18a55e192b035ef10c382f5535597b1f53f2e430b980735d930cabcd00"
    sha256 cellar: :any_skip_relocation, monterey:       "69127ba73f35783766bb0a3d9f08e4d19f5a146064a06587545e5ec035d6d368"
  end

  depends_on "go@1.20" => :build
  depends_on "node@20" => :build

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
