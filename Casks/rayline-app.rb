cask "rayline-app" do
  version "0.1.0"
  sha256 "5b2033c1728e0cd68c3ed8cdcbb3fc4097d573e9d073a168e151cfde29e67ce9"

  url "https://get.rayline.ai/cli/v0.1.0+c9852304cc72/Rayline.dmg"
  name "Rayline"
  desc "Rayline menu bar app with bundled rl CLI and rld router daemon"
  homepage "https://rayline.ai/"

  livecheck do
    url "https://get.rayline.ai/cli/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates false
  depends_on macos: ">= :ventura"
  depends_on arch: :arm64

  app "Rayline.app"
  binary "#{appdir}/Rayline.app/Contents/Resources/bin/rl"
  binary "#{appdir}/Rayline.app/Contents/Resources/bin/rld"

  zap trash: [
    "~/.config/rayline",
    "~/.rayline",
    "~/Library/Application Support/Rayline",
    "~/Library/Preferences/ai.rayline.Rayline.plist",
    "~/Library/Saved Application State/ai.rayline.Rayline.savedState",
  ]
end
