class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.1.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.1+3a9f2c4511fb/homebrew/rayline-0.1.1-macosx_11_0_arm64.tar.gz"
      sha256 "4c50952542fe060a24d0fc1087cfa8c4baf8e1fdb9ef2043769e82cd45ed6fd5"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.1+3a9f2c4511fb/homebrew/rayline-0.1.1-macosx_10_12_x86_64.tar.gz"
      sha256 "8056875a4d520c7e7e4f8e4efe048f81d65b5fdba1d87c8ce275d76c77c51ac3"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.1+3a9f2c4511fb/homebrew/rayline-0.1.1-linux_aarch64.tar.gz"
      sha256 "1c8206a61af3003ab231dacac3f1057b5d87139202b4beb7a7bf263ac25e87f4"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.1+3a9f2c4511fb/homebrew/rayline-0.1.1-linux_x86_64.tar.gz"
      sha256 "a4874a776dd5f136c5703079b3b10261b7b62ecb7e2278cbcbc14bb7bc006a50"
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
      Run `rayline claude` to launch Claude Code through Rayline.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rayline --version")
    assert_match "rld", shell_output("#{bin}/rld --version")
  end
end
