require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.3-beta/zli-6.36.3-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "5d76900abecfb28bad7b197f3d4dc480a6ffeaf61d6b014b1178aa1ba2e0bf92"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.3-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "91b9be2c21ec6067c0f21549ceebae83c4213a4babc3a4b110e2b9bd8bca30f5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "394b632e1927e3ebfbe51e6a42ced502752140f9dc8903e02a963ea4adc13d00"
    sha256 cellar: :any_skip_relocation, ventura:        "93f1369d7191ebf4586eb9db196d40d92912095015267a456e61f31bd59b70d0"
    sha256 cellar: :any_skip_relocation, monterey:       "1c5f2ff5f753665054f3a979e5a8e27bf1cdd81a80e678aab6392588b42746e7"
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
