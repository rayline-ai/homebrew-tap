class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.8"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.8+108012255153/homebrew/rayline-0.2.8-macosx_11_0_arm64.tar.gz"
      sha256 "355ee78867d1392fc05bafaee9b4d17795bbe15087642e8758907b317ad0252d"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.8+108012255153/homebrew/rayline-0.2.8-macosx_10_12_x86_64.tar.gz"
      sha256 "d20c6849b37d296fa1f4ffd0f9e361d474c23e350ce1466bdfc781be060620bf"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.8+108012255153/homebrew/rayline-0.2.8-linux_aarch64.tar.gz"
      sha256 "ebbb2d094287f5fb5fd041f77d4614f2ef2c41af7dfb3bd7dbc45ae909fc63bb"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.8+108012255153/homebrew/rayline-0.2.8-linux_x86_64.tar.gz"
      sha256 "05ddf8c6c80dd6d72b889a8f18af99a7d59ca20e2874b390779ea74a35b39cd2"
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
