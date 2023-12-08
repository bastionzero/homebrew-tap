require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.35.3-beta/zli-6.35.3-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "9895d37c751bc2d25e985e487ee17715e02f975445359eda6f7216d6ffda2312"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.35.3-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "95b415e52eeb6488270f7a8a60477bf444729dcf2749c19a57adb7a206edfa87"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "63fc2a68692c0914fedf29e5c0d49cf203df71e77f241fa3688e41f760d12ef3"
    sha256 cellar: :any_skip_relocation, ventura:        "d987e8ce12164bb1a112245a85993b29828e244eb0184140f7480a6f856ae377"
    sha256 cellar: :any_skip_relocation, monterey:       "ad6076fb4c233fb8c1eea0b78806f46599e93d642ff31e4f8f612e31511d6f51"
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
