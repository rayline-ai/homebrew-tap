class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.6"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.6+4bfa7c362b68/homebrew/rayline-0.5.6-macosx_11_0_arm64.tar.gz"
      sha256 "f320a6d00de727bbafc391a7087a70cfea61a92c0f8a393b15f50fc07b45f3a2"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.6+4bfa7c362b68/homebrew/rayline-0.5.6-macosx_10_12_x86_64.tar.gz"
      sha256 "25ea9d570c00638931d983dc63fd670ff8510f91f5940715f5002740d6bb5dcc"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.6+4bfa7c362b68/homebrew/rayline-0.5.6-linux_aarch64.tar.gz"
      sha256 "2d16245c30f923ba4d25185263ab8321a072cde248cbdc7bb9fec7156328dcd1"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.6+4bfa7c362b68/homebrew/rayline-0.5.6-linux_x86_64.tar.gz"
      sha256 "639b762d7b89ee653af504ccd2b67c5d21c78c3016adc53f1a5490d60a7bf1a2"
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
