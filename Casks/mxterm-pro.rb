cask "mxterm-pro" do
  # MXterm Pro ships one always-latest DMG (replaced server-side on each release), so the
  # download URL is not versioned and Homebrew needs `sha256 :no_check` (a pinned sha would
  # break the moment a release replaces the file). Integrity is still checked at launch by
  # macOS Gatekeeper: the app is Developer ID signed and notarized. `version` follows the
  # app's own update manifest (latest.json) for display and livecheck; installed copies
  # update themselves from inside the app (auto_updates true), so this cask only gates the
  # first `brew install`. Bump `version` on each release: ./bump-version.sh
  version "1.1.73"
  sha256 :no_check

  url "https://mxterm.net/download/mxTerm.dmg"
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
  depends_on macos: ">= :catalina"

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
