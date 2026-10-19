class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.9"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.9+941e45901b98/homebrew/rayline-0.2.9-macosx_11_0_arm64.tar.gz"
      sha256 "9c833a032c42610f85e2ed034ac7f3fec86bbd674e53f5bd51fa58946221e887"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.9+941e45901b98/homebrew/rayline-0.2.9-macosx_10_12_x86_64.tar.gz"
      sha256 "51e577b666e3e180b3f2760c29a457d0c587d8fe976501f15fe621c9922266aa"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.9+941e45901b98/homebrew/rayline-0.2.9-linux_aarch64.tar.gz"
      sha256 "16a6694016b1e2a1fd50fb241a9e0b170ff5cbed4b4d32843c677a08093e8dd0"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.9+941e45901b98/homebrew/rayline-0.2.9-linux_x86_64.tar.gz"
      sha256 "c7b68fd5f1ad53568cd9e35fc7c9c964b6365ea40c73ff7492105a8d2c8a5070"
    end
  end

  livecheck do
    url "https://get.rayline.ai/cli/latest.json"
    regex(/"version"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  def install
    bin.install "rayline"
    bin.install "rld"
  end

  def caveats
    <<~EOS
      Run `rayline claude --local-router` to launch Claude Code through Rayline.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rayline --version")
    assert_match "rld", shell_output("#{bin}/rld --version")
  end
end
