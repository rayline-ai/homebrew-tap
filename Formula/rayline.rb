class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.7"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.7+f7e5e7c5d289/homebrew/rayline-0.5.7-macosx_11_0_arm64.tar.gz"
      sha256 "2ea904b538098606838fad52f4c2f09c97a85c0c64d6f958641c6ee379c46de4"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.7+f7e5e7c5d289/homebrew/rayline-0.5.7-macosx_10_12_x86_64.tar.gz"
      sha256 "bf28c356c93b3ad38dc8f557c2cfe8c507748b12a5082752418b504401ee14f5"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.7+f7e5e7c5d289/homebrew/rayline-0.5.7-linux_aarch64.tar.gz"
      sha256 "449cc5182d72c71778426e4baf0f045dbd4514128910f868dc54530cca3e75ef"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.7+f7e5e7c5d289/homebrew/rayline-0.5.7-linux_x86_64.tar.gz"
      sha256 "4da011a397683cb135b17bf7614ec93ea50235ed83b90f0bf97ef806854ed068"
    end
  end

  livecheck do
    url "https://get.rayline.ai/cli/latest.json"
    regex(/"version"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  def install
    bin.install "rayline"
    # Hybrid execution core: rayline resolves it next to its own executable.
    bin.install "rayline-core"
    pkgshare.install "rayline-core-LICENSE"
    pkgshare.install "rayline-core-source.json"
  end

  def caveats
    <<~EOS
      Run `rayline auth login`, then `rayline run claude` to launch Claude Code on ARC
      (Sage for the main agent, Swift for subagents). `rayline run claude --local`
      routes through the local Rayline process instead.
    EOS
  end

  test do
    assert_match "rayline #{version}", shell_output("#{bin}/rayline --version")
    assert_path_exists bin/"rayline-core"
    assert_path_exists pkgshare/"rayline-core-LICENSE"
    # The Go core needs macOS 13+; the Rust CLI still supports older macOS.
    if OS.linux? || MacOS.version >= :ventura
      assert_match "contract_version", shell_output("#{bin}/rayline-core --version")
    end
  end
end
