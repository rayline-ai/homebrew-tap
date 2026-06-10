cask "rayline-app" do
  version "0.1.1"
  sha256 "51d02b10522fd70c845b3f6d35ce577ff50c7980438759fab42277604c6a190c"

  url "https://get.rayline.ai/cli/v0.1.1+ecdd9d418171/Rayline.dmg"
  name "Rayline"
  desc "Rayline menu bar app with bundled rayline CLI and rld router daemon"
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
  binary "#{appdir}/Rayline.app/Contents/Resources/bin/rayline"
  binary "#{appdir}/Rayline.app/Contents/Resources/bin/rld"

  zap trash: [
    "~/.config/rayline",
    "~/.rayline",
    "~/Library/Application Support/Rayline",
    "~/Library/Preferences/ai.rayline.Rayline.plist",
    "~/Library/Saved Application State/ai.rayline.Rayline.savedState",
  ]
end
