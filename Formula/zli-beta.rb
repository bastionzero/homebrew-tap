require "language/node"
require "os"
require_relative "../lib/git_hub_private_repository_download_strategy"

class ZliBeta < Formula
  desc "BastionZero cli - Beta"
  homepage "https://www.bastionzero.com"
  url "https://github.com/bastionzero/zli/releases/download/6.36.25-beta/zli-6.36.25-beta.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "19cde52351e43a0c50026abe1908577607fe69494471280a9ef7fb95a95c3cc9"
  license "Apache-2.0"
  head "https://github.com/bastionzero/zli.git", branch: "master"

  bottle do
    root_url "https://github.com/bastionzero/homebrew-tap/releases/download/zli-beta-6.36.25-beta"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "76a58fa6b4b723c979858a621300d7f5695e145410f2f0633609d5b858fcd40f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ffa78c213835790c5be165cac28aa97fabf35c579bd7ce26c8b3557f69035dad"
  end

  depends_on "go@1.20" => :build
  depends_on "node@20" => :build

  def install
    system "npm", "install"
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
