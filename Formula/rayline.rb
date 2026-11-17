class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.5"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.5+871502f5a39b/homebrew/rayline-0.5.5-macosx_11_0_arm64.tar.gz"
      sha256 "26b0a04a3e3280611bec8e168100f6f252e6922744d41df82909f68e0baf3125"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.5+871502f5a39b/homebrew/rayline-0.5.5-macosx_10_12_x86_64.tar.gz"
      sha256 "ed56a075ce1e54a724ba09369489ec0747cfca905edaa76deafa89074570eda2"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.5+871502f5a39b/homebrew/rayline-0.5.5-linux_aarch64.tar.gz"
      sha256 "2517ce7cc1cc392bda30791450727c3d7b8eb93a5a4f86e23b5dd8f2995c2f1b"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.5+871502f5a39b/homebrew/rayline-0.5.5-linux_x86_64.tar.gz"
      sha256 "0c99cbebe89a9806186c4ee26387b620069ad180dfa16670554144696958ec1e"
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
