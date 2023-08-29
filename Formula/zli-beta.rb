require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.32.0-beta/zli-6.32.0-beta.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "46df7b53042ca6a11a68d5761f97637480c85acfd027be03117df785c4f17493"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.32.0-beta"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "665ec5304498c57fa144c153a77b580104cb4c459d830534e3d1171ab9eeb328"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "63fe7841bc28cf4f09bada9d0537fe8280d07230a1e448c30c6c6893127feb55"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "bb0b6c2830b124b325eb807330d5bbe12d0823d269f7a07a37121770dba38346"
    sha256 cellar: :any_skip_relocation, ventura:        "2aebc3662376b8c8af7a2ebd08ffd47808399241fdf5fb499f4037bdc97537ad"
    sha256 cellar: :any_skip_relocation, monterey:       "e7300d32f4303de0dddbf0b1029c15fe09938a047994d167ab99020892986764"
    sha256 cellar: :any_skip_relocation, big_sur:        "28381beba37dc84074a511c9e30fedf0e9880d46fdf65d1620a19919d022d2a1"
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
