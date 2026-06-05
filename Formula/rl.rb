class Rl < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+97c558837fda/homebrew/rl-0.1.0-macosx_11_0_arm64.tar.gz"
      sha256 "0fd770739eb04522c9df141d931d90e0ebae0ab0fc976fa95afb311a67e431bb"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+97c558837fda/homebrew/rl-0.1.0-macosx_10_12_x86_64.tar.gz"
      sha256 "e6802e4e5b090a2dd8f98496679495bda04760533bd62e9aca5ddec926f5940f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+97c558837fda/homebrew/rl-0.1.0-linux_aarch64.tar.gz"
      sha256 "3aefb7265e0970ed40d4ef1eba5846837f8fc82b0d93a0332aab0583113f5f9c"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+97c558837fda/homebrew/rl-0.1.0-linux_x86_64.tar.gz"
      sha256 "2c7a168c70bbed8755710be9a639e5ed14e7fba87808e28ff5a79d2afdfb0e36"
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
