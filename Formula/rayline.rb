class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.1+10f6a38b1389/homebrew/rayline-0.5.1-macosx_11_0_arm64.tar.gz"
      sha256 "02bb896309244affb0021a9dda8d27ef88b8db2bce2b23a398fa233be1bf5e45"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.1+10f6a38b1389/homebrew/rayline-0.5.1-macosx_10_12_x86_64.tar.gz"
      sha256 "6a622f6df1371b8136c4ea132eaf74f4d392369d150e3f315580f8638d437b86"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.1+10f6a38b1389/homebrew/rayline-0.5.1-linux_aarch64.tar.gz"
      sha256 "3c6a02aac58bc0a0323519d69111add23be0a3f8b569a1def1149040f13ed1c6"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.1+10f6a38b1389/homebrew/rayline-0.5.1-linux_x86_64.tar.gz"
      sha256 "ae2864e3011032055c315a4eabe208f906a8aad810c345b10cc74b041b1ad4bb"
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
