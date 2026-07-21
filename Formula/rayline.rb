class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.5"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.5+81235cbb84b8/homebrew/rayline-0.2.5-macosx_11_0_arm64.tar.gz"
      sha256 "6d02c6f603910afba951870c041798ab6a021023443caf8b985c221ce281ea4b"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.5+81235cbb84b8/homebrew/rayline-0.2.5-macosx_10_12_x86_64.tar.gz"
      sha256 "7046e220630cd7ac74de22d4fd3985e0e1f26c80e04473ea1486e19a1c9114e1"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.5+81235cbb84b8/homebrew/rayline-0.2.5-linux_aarch64.tar.gz"
      sha256 "0e9ad9c13145cb5334a69f897827beaf5afebd334c7cb8dcb9607ec150f35070"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.5+81235cbb84b8/homebrew/rayline-0.2.5-linux_x86_64.tar.gz"
      sha256 "fd9d5b7db07bc60ddc95efd9630a0409fe78d0e864512a9601ef3d3df7c355b3"
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
