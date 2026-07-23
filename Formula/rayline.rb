class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.6"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.6+7bd2849c99d2/homebrew/rayline-0.2.6-macosx_11_0_arm64.tar.gz"
      sha256 "6a8bbf455a8214ae607c6d5580ba0cc22b7a3fabaafe7b5e7ab324b0b1635384"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.6+7bd2849c99d2/homebrew/rayline-0.2.6-macosx_10_12_x86_64.tar.gz"
      sha256 "6b41790776b5caa560a90c9bf8e82c2a4ae4691bcef3e428fd274e947901c91a"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.6+7bd2849c99d2/homebrew/rayline-0.2.6-linux_aarch64.tar.gz"
      sha256 "c10228ccad8ff6b365db10c54891a6711ed5e4488acbbad52430ca749c51709b"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.6+7bd2849c99d2/homebrew/rayline-0.2.6-linux_x86_64.tar.gz"
      sha256 "6a9c7ef566166a1abcfa379c8595e08c9154725eab0f5247addd653f760c65b6"
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
