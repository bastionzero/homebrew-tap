require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.2-beta/zli-6.36.2-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "35993e30f92f280d55a3739247ef71a56fb47988ef19c0eb57d3d02f8937c4c9"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.2-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f7f8d6a18eff80edf94af3918e8d1803c4fddbf8b3d553f0506d5a407cbc025b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5ed3dd6e8611431784fa25bece973d7e92e01411b3d0eafb223d14e01efcd8ca"
    sha256 cellar: :any_skip_relocation, ventura:        "fbf128abd402839d95bed0256907d55a4bca9419603939774282a28ced8e0bcc"
    sha256 cellar: :any_skip_relocation, monterey:       "61cc05a0d00e5193e2d9d075d27fd42925020b21d2865b8a77ddcbfdc980777d"
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
