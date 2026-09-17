class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.7"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.7+3bc45a8238ad/homebrew/rayline-0.2.7-macosx_11_0_arm64.tar.gz"
      sha256 "1ec04d412960247312e86bd11debada33cb2a372383d0ace45eb248fa738c973"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.7+3bc45a8238ad/homebrew/rayline-0.2.7-macosx_10_12_x86_64.tar.gz"
      sha256 "1e3b781300704130ae3f42bc51cb6393111001493de41b112351c965f2220816"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.7+3bc45a8238ad/homebrew/rayline-0.2.7-linux_aarch64.tar.gz"
      sha256 "0f86ff69d5f1c744bdb3ce01fec3da748bb09619683f7fe688f1aff8a7ce72ad"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.7+3bc45a8238ad/homebrew/rayline-0.2.7-linux_x86_64.tar.gz"
      sha256 "63765b4b3178449224a555b5a96bf11235b98bdd1eef4ba433538579d66f2db8"
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
