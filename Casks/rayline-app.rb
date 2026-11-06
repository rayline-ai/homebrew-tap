cask "rayline-app" do
  version "0.4.1"
  sha256 "2cd5e420b9b832ef7d3e33c67de2bc4b423b8f3502faddb76d506c33bd6ee3ca"

  url "https://get.rayline.ai/cli/v0.4.1+2abd0dbcc7ee/Rayline.dmg"
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
