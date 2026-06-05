class Rl < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+43d5461fa8d2/homebrew/rl-0.1.0-macosx_11_0_arm64.tar.gz"
      sha256 "ff1b2847290845606b08dea3392be217d4e92f92e3669ccb0dee29c5ca2e83d6"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+43d5461fa8d2/homebrew/rl-0.1.0-macosx_10_12_x86_64.tar.gz"
      sha256 "4cda58696756c362261e12ef58ca61f80c4ee785d2c73b339ac5438e29a8d88c"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+43d5461fa8d2/homebrew/rl-0.1.0-linux_aarch64.tar.gz"
      sha256 "85f2a21b47505938a506443447505f24c72a704bd0d71d1d74f93b96e7a355aa"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+43d5461fa8d2/homebrew/rl-0.1.0-linux_x86_64.tar.gz"
      sha256 "5bda224a504ba7975f4f3abf59b534f030049eeb3ef8aaeec7487fa27d08f7b8"
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
