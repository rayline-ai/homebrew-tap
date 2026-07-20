class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.4+4af32bb57ca7/homebrew/rayline-0.2.4-macosx_11_0_arm64.tar.gz"
      sha256 "fce510e46b327a584c96d6f9452caee76d8f1cfca5fa17b1f06a11adf87df30f"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.4+4af32bb57ca7/homebrew/rayline-0.2.4-macosx_10_12_x86_64.tar.gz"
      sha256 "e64158f7cfb1ab09f501fd1b8b81f4b96eaa6258d67091743afac177451521cd"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.4+4af32bb57ca7/homebrew/rayline-0.2.4-linux_aarch64.tar.gz"
      sha256 "cc5130f477ebd4bd42fc0f94dc2ad254b390e46849c1e976529a4f912ecb0aca"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.4+4af32bb57ca7/homebrew/rayline-0.2.4-linux_x86_64.tar.gz"
      sha256 "b675cd2ed79b1db3f66260074dc5f1352022f7b387bcd6181298d856a5716309"
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
