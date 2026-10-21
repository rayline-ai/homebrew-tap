class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.10"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.10+a2db8785f30c/homebrew/rayline-0.2.10-macosx_11_0_arm64.tar.gz"
      sha256 "1ea46302babd8790c7adab0f79b288c7087209b764191e753fa9237713278276"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.10+a2db8785f30c/homebrew/rayline-0.2.10-macosx_10_12_x86_64.tar.gz"
      sha256 "a078f2907ad28c81d25804545406624130a1d64851f173cb0b2452b40139c2df"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.10+a2db8785f30c/homebrew/rayline-0.2.10-linux_aarch64.tar.gz"
      sha256 "6ba1aa5730fa10adbd422766b24a4708d141b53adce54b4c89b1cbad36759241"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.10+a2db8785f30c/homebrew/rayline-0.2.10-linux_x86_64.tar.gz"
      sha256 "c10fb967a56a542d16fd5da5aaeaf7f078dc5476ab2716d8fe149806d0257eff"
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
