require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class Zli < Formula
  desc "BastionZero cli"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.21/zli-6.36.21.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "2fc9a5d563dc36028f558650add5a3e7c5045fe381714aa2424827b5ede53b45"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-6.36.21"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "738d7615bd74be7a3774fc8d3cd985a6f51c559d5e100075a902ccbea89a0586"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4ec590ff360eed42f1384ffa5bf7a6ac419055aa5515610a10a5bff7b13c6143"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "49cdf620908b46db82f6685ef3d96798794d4415b1df5bfc5046ad63912d6ec5"
    sha256 cellar: :any_skip_relocation, ventura:       "058f82b3f98d0ee03937a49a9b394d20636a9a4e89f491197ab1cf14df65a669"
  end

  depends_on "go@1.20" => :build
  depends_on "node@20" => :build

  def install
    system "npm", "install", *std_npm_args(prefix: false)
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
