class Rl < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+4b659e8420ae/homebrew/rl-0.1.0-macosx_11_0_arm64.tar.gz"
      sha256 "93bce9a0e0050186e79c0be1614ac7cfde800aead8a1cb18a13d2bbc93549a1f"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+4b659e8420ae/homebrew/rl-0.1.0-macosx_10_12_x86_64.tar.gz"
      sha256 "30571989f49214e55d630d0e0728e42984c35b1df28a8dc0d95dbad3106d9011"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+4b659e8420ae/homebrew/rl-0.1.0-linux_aarch64.tar.gz"
      sha256 "9ecf09eae946f87820ac5f235c6192f74f648e5b9fca2a3a0d2816b242d0c56b"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+4b659e8420ae/homebrew/rl-0.1.0-linux_x86_64.tar.gz"
      sha256 "06fb6b1bca60c8ff53482c884e2f2f111cd450d842d88675156e404a12ee144a"
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
