class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.0+cc70d2f73987/homebrew/rayline-0.5.0-macosx_11_0_arm64.tar.gz"
      sha256 "9812df1fbf08c06b2b273ffb109c5d4197b304264bc2a8d22c3f9f75c78a613d"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.0+cc70d2f73987/homebrew/rayline-0.5.0-macosx_10_12_x86_64.tar.gz"
      sha256 "dc38dfb58337709a59c3db9b40aac906121ce067c1561c08f99e280ef09f3ade"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.0+cc70d2f73987/homebrew/rayline-0.5.0-linux_aarch64.tar.gz"
      sha256 "229cb37ab4f8630d069cc5cadd9e396d191ef0c9bed611b2180ac6a1b588afc0"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.0+cc70d2f73987/homebrew/rayline-0.5.0-linux_x86_64.tar.gz"
      sha256 "87373a00eee66f454b1b1f6e56b6ef7d8321addba8396f4f72e2928810e3d876"
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
