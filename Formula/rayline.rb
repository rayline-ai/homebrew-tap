class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.8"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.8+12768da0dbac/homebrew/rayline-0.5.8-macosx_11_0_arm64.tar.gz"
      sha256 "7c716bebc644af61b46a5237f40a74c5e6122dea2038636bbfea917cee993ff4"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.8+12768da0dbac/homebrew/rayline-0.5.8-macosx_10_12_x86_64.tar.gz"
      sha256 "67f299810decf89155d9161484451b43b312942d0303f9767000c3d1a4ae1b27"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.8+12768da0dbac/homebrew/rayline-0.5.8-linux_aarch64.tar.gz"
      sha256 "09e8949f8f83bcb4347665e77b3c4c54fd9db209933fa5aab0e1585b64a641d1"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.8+12768da0dbac/homebrew/rayline-0.5.8-linux_x86_64.tar.gz"
      sha256 "89e3f2dc3b9f236d8fd7b17fdc93d3638cce1d2e92f3126cd0a6cf44ceaa228f"
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
