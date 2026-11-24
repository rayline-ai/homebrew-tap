class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.9"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.9+f11ef2f0f928/homebrew/rayline-0.5.9-macosx_11_0_arm64.tar.gz"
      sha256 "fc4a4ee11263ad65989b75587df22854d5882e7c3b41fea4d6df216825a380fe"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.9+f11ef2f0f928/homebrew/rayline-0.5.9-macosx_10_12_x86_64.tar.gz"
      sha256 "66670cf4a14ecfc88f0673d6536743017cc069f2e98e086e63bdef0199843a0d"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.9+f11ef2f0f928/homebrew/rayline-0.5.9-linux_aarch64.tar.gz"
      sha256 "855a2d91e3d41c27c897aa90c6867f48faabaa9b423221c8e0b53ec97f96a535"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.9+f11ef2f0f928/homebrew/rayline-0.5.9-linux_x86_64.tar.gz"
      sha256 "96b36d71ee06497c1200dcd7dba80b92de13b7bced6683d6af06b40bd16e01c1"
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
