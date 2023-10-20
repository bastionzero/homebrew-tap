cask "bzero-launcher" do
  version "0.1.4"
  sha256 "849d4d52fa3a07c1efc30676a89c8cfcd962d0cf83c4afc16ee4010007e7f00a"

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