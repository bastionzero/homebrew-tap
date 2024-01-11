require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.1/zli-6.36.1.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "a91cbd3bcc46dc208b4aad2ba96e6485eed954f2609605e92b85cdec15a2ccb2"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.36.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8868b290cba7fdf781a5b8bb098d5afa4543caa01885dc00cd4a921d965bed9f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "52ef0146ca100caaf7dc76ddbd18059c0dac592ca1e833fd0e381900661587e8"
    sha256 cellar: :any_skip_relocation, ventura:        "cda715cc1e83509caa948f8eeff052143918cb3f27ce355e298a26d94de555e5"
    sha256 cellar: :any_skip_relocation, monterey:       "00e7238e3cb0603598a22c43108d63c6fd39e2cadfcf0d92f4af9f0d5f30efc3"
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
