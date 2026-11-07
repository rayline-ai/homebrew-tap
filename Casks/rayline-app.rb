cask "rayline-app" do
  version "0.4.2"
  sha256 "5d4ab85f4b0bd9eb3586b087b6a955f7ce2a77d019877b0bb65851b814b6a8ac"

  url "https://get.rayline.ai/cli/v0.4.2+cd11a0bdc1e2/Rayline.dmg"
  name "Raydock"
  desc "Raydock menu bar app with bundled Raydock CLI and rld router daemon"
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
  # No `binary` stanzas: the app uses its embedded raydock/rld internally, and
  # symlinking them into Homebrew's bin would collide with the `raydock` formula
  # (which installs the same names). Users who want the CLI on PATH install the
  # formula: `brew install rayline-ai/tap/raydock`.

  zap trash: [
    "~/.config/rayline",
    "~/.rayline",
    "~/Library/Application Support/Rayline",
    "~/Library/Preferences/ai.rayline.Rayline.plist",
    "~/Library/Saved Application State/ai.rayline.Rayline.savedState",
  ]
end
