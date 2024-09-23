require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.19-beta/zli-6.36.19-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "f5ac689fb9d79f9fabcb169c028a160b10da174de27acfc602c2c234b86d16c2"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.19-beta"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "677d2d67dddd46576a7eaded3a88a43869dae22b4e64076cbaf77ab5ea0297a1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f713f792ccbdb151f1630f2806e33e705b4cacf2171bea72c17beb189779facf"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f973d6f324097c888484640c036eae4e203769e23d6670f2512ebc6e63d9527e"
    sha256 cellar: :any_skip_relocation, ventura:        "ea8499c8c430701119257968543a2d91d0dd8552f0fd0d96e302a43e9bd0227e"
    sha256 cellar: :any_skip_relocation, monterey:       "f9d8e920993177b9c16cba11e55b9f4a5cccaa4be43c55de6135929202b59be6"
  end

  depends_on "go@1.20" => :build
  depends_on "node@20" => :build

  def install
    system "npm", "install", *std_npm_args(prefix: false)
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
