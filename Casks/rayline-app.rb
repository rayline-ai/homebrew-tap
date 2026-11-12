cask "rayline-app" do
  version "0.4.5"
  sha256 "21dfb340fb25e02b15aaf7824339e36c65ad98de5b1011597cc52bb44370008e"

  url "https://get.rayline.ai/cli/v0.4.5+20d02f517d01/Rayline.dmg"
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
