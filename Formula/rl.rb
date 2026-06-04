class Rl < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+8a01db8a0cb1/homebrew/rl-0.1.0-macosx_11_0_arm64.tar.gz"
      sha256 "dd9939b4919cba84aa26e34e9ca191ae0bb92ca7814b0f809bea7ffbb13941c6"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+8a01db8a0cb1/homebrew/rl-0.1.0-macosx_10_12_x86_64.tar.gz"
      sha256 "c6f4cef89cd22ad1cf1f9b92aef06b7ec9ace7a01d1d8c5185c67d3305589642"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+8a01db8a0cb1/homebrew/rl-0.1.0-linux_aarch64.tar.gz"
      sha256 "4fb53262948b5a4edbdf960083c7d2aaeddc43f8f29f9517f9ff3938347befc1"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+8a01db8a0cb1/homebrew/rl-0.1.0-linux_x86_64.tar.gz"
      sha256 "401f92f208824a2191c58c8fd2a5c96d45aa171bb48e41798540c12c35c3f304"
    end
  end

  livecheck do
    url "https://get.rayline.ai/cli/latest.json"
    regex(/"version"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  def install
    bin.install "rl"
    bin.install "rld"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rl --version")
    assert_match "rld", shell_output("#{bin}/rld --version")
  end
end
