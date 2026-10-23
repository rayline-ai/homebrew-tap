class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.12"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.12+ee1afb00b6cd/homebrew/rayline-0.2.12-macosx_11_0_arm64.tar.gz"
      sha256 "49f01433cb0a716bdb1a69179f100334e839a3835c1de4ba0c9faa8ff5f30d45"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.12+ee1afb00b6cd/homebrew/rayline-0.2.12-macosx_10_12_x86_64.tar.gz"
      sha256 "f6876b1ec5dd423ceea54d85a500e4cf0e60d940e98fbc7569366f8622a60adf"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.12+ee1afb00b6cd/homebrew/rayline-0.2.12-linux_aarch64.tar.gz"
      sha256 "a7d2502624901d48320825e9fe314e0c0807232aebe43ac03b7099371f15ddcb"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.12+ee1afb00b6cd/homebrew/rayline-0.2.12-linux_x86_64.tar.gz"
      sha256 "38e0576d31bf770a47a7a93920022f1dd497390ec4bbe0e9567bc8a8861581d6"
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
