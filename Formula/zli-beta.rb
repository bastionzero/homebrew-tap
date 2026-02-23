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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "590a04efe814dd5f22abd2b159e1391c01639e729047da23f13d156d16a6dac1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "37174fb8f92c86c05df49aae33c0758c34c59afaefda1822b1a57acb5d5a32eb"
  end

  depends_on "go" => :build
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
