require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.27.4/zli-6.27.4.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "a67d655d0ce42f86f6ef3f50821176612c030fabc79cf0efc8464cdc75471c6a"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.27.4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a1ef0406904a102197d63ea0e80ba8afb168ecb9dc56593c50cf1990d6f465b2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e6b3b5dce10a231da396bf0cd7cabbc31270b151b2760cc9bf489bcdc3589148"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f21d3d6cb7deb7c5a28f8bf7534dc6882a50406a2d2ce38005bc989b5b0bd7f0"
    sha256 cellar: :any_skip_relocation, ventura:        "040274f94203ae311deafccd7d749d65df96dc5a6970f8efb2f4e8de264d37f7"
    sha256 cellar: :any_skip_relocation, monterey:       "a266b068ef6d554f6edb821ceb33e557456e7f5ec7efce2f8cc653dad88a1866"
    sha256 cellar: :any_skip_relocation, big_sur:        "7e25ce2d767ebc3f3ce4bdebc904f7f038ad68010946a6b5d5a23258e8071bf4"
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
