cask "rayline-app" do
  version "0.2.7"
  sha256 "6abe047f3175540c7b625bf920c27528ef8a3929de5f40ec99fb4dc26afc23dd"

  url "https://get.rayline.ai/cli/v0.2.7+3bc45a8238ad/Rayline.dmg"
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
  # No `binary` stanzas: the app uses its embedded rayline/rld internally, and
  # symlinking them into Homebrew's bin would collide with the `rayline` formula
  # (which installs the same names). Users who want the CLI on PATH install the
  # formula: `brew install rayline-ai/tap/rayline`.

  zap trash: [
    "~/.config/rayline",
    "~/.rayline",
    "~/Library/Application Support/Rayline",
    "~/Library/Preferences/ai.rayline.Rayline.plist",
    "~/Library/Saved Application State/ai.rayline.Rayline.savedState",
  ]
end
