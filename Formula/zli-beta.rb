require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.21-beta/zli-6.36.21-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "efcbd94c7a960aab45ee471a76a753f4bcab86bffa96e3b7079a409ff8f9ce5e"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.21-beta"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "de9dd822926a2163b4a73c7224d1985c8e5ad2127a942172283fb45d98024e1f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "82d1f7aefce158ce6ffb58afe29466eea7182a2fc15175d960d0621b49234c38"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "da335d7f2432b9494897fc310736990227910aec255d1ce3cf7888139b916f5b"
    sha256 cellar: :any_skip_relocation, ventura:       "770e8a75e4930fb895b4c1a0eac7a2b9453bc0613606c4f19b9602adc2d5c746"
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
