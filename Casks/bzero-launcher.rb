cask "bzero-launcher" do
  version "0.1.9,20231102.160228"
  sha256 :no_check

  url "https://download-desktop-app.bastionzero.com/release/latest/bin/macos-latest.dmg"
  name "Bzero Launcher"
  desc "BastionZero desktop launcher. Remote access services, ready to connect."
  homepage "https://bastionzero.com/"

  livecheck do
    url :url
    strategy :extract_plist
  end

  app "bzero-launcher.app"

  uninstall quit: [
    "com.bastionzero.launcher",
  ]

  zap trash: [
    "~/Library/Preferences/bastionzero-logger-nodejs/bastionzero-app.log"
  ]
end
