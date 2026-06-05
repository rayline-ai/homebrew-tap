class Rl < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+3904e18985e4/homebrew/rl-0.1.0-macosx_11_0_arm64.tar.gz"
      sha256 "666b9d1376b9a02e32a714ecb07e5fe84b6b16cbf94b6364c0ac1e21e5594ec2"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+3904e18985e4/homebrew/rl-0.1.0-macosx_10_12_x86_64.tar.gz"
      sha256 "d4b0aef5cbf0d725b65686ce66651aadc9e4b779da860fff7c5438b153e7a5d3"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+3904e18985e4/homebrew/rl-0.1.0-linux_aarch64.tar.gz"
      sha256 "b4be9443c905dc32614ad559518458fdadbca96087e7e8723f2de0752f7afa2a"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+3904e18985e4/homebrew/rl-0.1.0-linux_x86_64.tar.gz"
      sha256 "00ad8e92627c62124940c899480c8aa79f0719f7d524620efc3c23d2f98f1125"
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
