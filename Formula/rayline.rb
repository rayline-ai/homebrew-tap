class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.4+9e6a3191e569/homebrew/rayline-0.5.4-macosx_11_0_arm64.tar.gz"
      sha256 "3aef8c7b41dda007d27968764c38e06284f927e16da87a04b554fe7fcf0e457e"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.4+9e6a3191e569/homebrew/rayline-0.5.4-macosx_10_12_x86_64.tar.gz"
      sha256 "1f2e6e6f9a4c0699531d755c96dfa9ee0a3b3cef4115898e0f55072949247ed0"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.4+9e6a3191e569/homebrew/rayline-0.5.4-linux_aarch64.tar.gz"
      sha256 "a1a63b721a112af7243c0bb10767e8c48da484e7b0ec9da9ff81a2c452914589"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.4+9e6a3191e569/homebrew/rayline-0.5.4-linux_x86_64.tar.gz"
      sha256 "0aac451b385c0ca409e794598ac2f53ad577a9714619c80982df87efa6646ca0"
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
