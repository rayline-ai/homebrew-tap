cask "rayline-app" do
  version "0.1.0"
  sha256 "5dce30cd132399562fda52c3e906c53b887bc4dd293a1401e8bd2a34998aceed"

  url "https://get.rayline.ai/cli/v0.1.0+3904e18985e4/Rayline.dmg"
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
