class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.10"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.10+c71be0f1f95e/homebrew/rayline-0.5.10-macosx_11_0_arm64.tar.gz"
      sha256 "2d4ac5287102e75bbf2631114a57d7fd6b642487bbbad1ef3eb3e7f19ab1fddc"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.10+c71be0f1f95e/homebrew/rayline-0.5.10-macosx_10_12_x86_64.tar.gz"
      sha256 "bbce48dd5086ae41cfa7db7b95fc7302b56cafa60d53d7b7d9966e4b44eb5d7e"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.10+c71be0f1f95e/homebrew/rayline-0.5.10-linux_aarch64.tar.gz"
      sha256 "5170a8e8f014b9a0556dd8de5630eaf26f9573dc32d821436a4f63e24cc139c5"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.10+c71be0f1f95e/homebrew/rayline-0.5.10-linux_x86_64.tar.gz"
      sha256 "56152b4b080e43d3704030a8e234afb3fffbce82c9cb9841f10cbdc545a2574e"
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
