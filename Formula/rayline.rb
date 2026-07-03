class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.3+f89868badf0e/homebrew/rayline-0.2.3-macosx_11_0_arm64.tar.gz"
      sha256 "afff1555a2b9d63f80e715c2ce8acd13ed192997b57d099aaca905200f30d0b7"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.3+f89868badf0e/homebrew/rayline-0.2.3-macosx_10_12_x86_64.tar.gz"
      sha256 "e3aca97a35e95e7abf3d08022452f2b12325745370645e190a84181435977bb7"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.3+f89868badf0e/homebrew/rayline-0.2.3-linux_aarch64.tar.gz"
      sha256 "a8e88fa256055cf7b2f18824887700fb754bc6c79beb1453ab46e1d856f6f776"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.3+f89868badf0e/homebrew/rayline-0.2.3-linux_x86_64.tar.gz"
      sha256 "823e9756cb995eb0633a16600506c9a7fb80b6163e4c9b0da90640b0ea31dc12"
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
