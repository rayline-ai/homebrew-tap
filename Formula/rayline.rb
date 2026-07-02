class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.2+f89868badf0e/homebrew/rayline-0.2.2-macosx_11_0_arm64.tar.gz"
      sha256 "b5c95254d1a0aef424936ee03793a957423c5d3339b01f22ce86d0d39ac8da91"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.2+f89868badf0e/homebrew/rayline-0.2.2-macosx_10_12_x86_64.tar.gz"
      sha256 "87d94901dbd532ed7a2bed272160158a14a0331f1725a49213298781989e5bcd"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.2+f89868badf0e/homebrew/rayline-0.2.2-linux_aarch64.tar.gz"
      sha256 "179bb5d05ee56df6daf91e656c1542f82fd630e783be1ed4dff9d64e5f61d6e6"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.2+f89868badf0e/homebrew/rayline-0.2.2-linux_x86_64.tar.gz"
      sha256 "1aa9c3ff269d819e6a0ae9bc4269f61bc881954a16d11ae2f511fd5c06843d73"
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
