cask "mxterm-pro" do
  # The DMG is pinned: every release also publishes `MXterm-Pro_<version>_universal.dmg` and its `.sha256`
  # beside the always-latest `mxTerm.dmg`, and ./bump-version.sh sets `version` and `sha256` together from
  # them. The app is also Developer ID signed and notarized (Gatekeeper checks it at launch). `version`
  # follows the app's own update manifest (latest.json); installed copies update themselves from inside
  # the app (auto_updates true), so this cask only gates the first `brew install`.
  version "1.1.80"
  sha256 "503d24690fafe93f06eac84b589fe35ef3022583acc1b98eb492359069130162"

  url "https://mxterm.net/download/MXterm-Pro_#{version}_universal.dmg"
  name "MXterm Pro"
  desc "Terminal for AI coding agents, SSH and SFTP"
  homepage "https://mxterm.net/"

  livecheck do
    url "https://mxterm.net/download/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on :macos

  app "MXterm Pro.app"

  zap trash: [
    "~/Library/Application Support/com.mxterm.desktop",
    "~/Library/Caches/com.mxterm.desktop",
    "~/Library/HTTPStorages/com.mxterm.desktop",
    "~/Library/HTTPStorages/com.mxterm.desktop.binarycookies",
    "~/Library/Preferences/com.mxterm.desktop.plist",
    "~/Library/Saved Application State/com.mxterm.desktop.savedState",
    "~/Library/WebKit/com.mxterm.desktop",
  ]
end
