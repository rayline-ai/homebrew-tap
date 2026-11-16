class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.2+3e23c3e98424/homebrew/rayline-0.5.2-macosx_11_0_arm64.tar.gz"
      sha256 "a08c7456c55b25972e6f9b2a6117994748cc7daa91c4804d9914f01b2e336e0b"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.2+3e23c3e98424/homebrew/rayline-0.5.2-macosx_10_12_x86_64.tar.gz"
      sha256 "da2ce423b36f8071da2094228ba2b068e4a3ca76dadbd12ae419b5aa4c667017"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.2+3e23c3e98424/homebrew/rayline-0.5.2-linux_aarch64.tar.gz"
      sha256 "c911f9c3e06acc9441fa9a99208be9546a4fb4c855c3ad9b98bae956a20477fc"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.2+3e23c3e98424/homebrew/rayline-0.5.2-linux_x86_64.tar.gz"
      sha256 "535df9371bc50295ff57adacbb55817245ba5f9c9ee6f538385f3d1141c54398"
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
    # The local ARC encoder ships in the macOS arm64 archive only, beside rayline (which looks for it there).
    if File.exist?("rayline-arc-encoder")
      bin.install "rayline-arc-encoder"
      pkgshare.install "rayline-arc-encoder-LICENSE"
    end
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
    assert_path_exists pkgshare/"rayline-arc-encoder-LICENSE" if (bin/"rayline-arc-encoder").exist?
    # The Go core needs macOS 13+; the Rust CLI still supports older macOS.
    if OS.linux? || MacOS.version >= :ventura
      assert_match "contract_version", shell_output("#{bin}/rayline-core --version")
    end
  end
end
