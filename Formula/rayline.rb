class Rayline < Formula
  desc "Rayline CLI that launches coding harnesses on ARC"
  homepage "https://rayline.ai"
  version "0.5.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.3+3bc25bc98f31/homebrew/rayline-0.5.3-macosx_11_0_arm64.tar.gz"
      sha256 "6acf62343563449f3be3c2ad99ed3f679ee11dcc6d363f373b7d56c98fb7a337"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.3+3bc25bc98f31/homebrew/rayline-0.5.3-macosx_10_12_x86_64.tar.gz"
      sha256 "19ded322ba4f74fd64bb5670a4da89c2a0bf4b32dbcfc2172f0a4eae0bffd4d3"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.5.3+3bc25bc98f31/homebrew/rayline-0.5.3-linux_aarch64.tar.gz"
      sha256 "52b506b293556a3a3a2cb3be0aa3be1b3ec6aa0e3cab545adcdc35591f8e9a28"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.5.3+3bc25bc98f31/homebrew/rayline-0.5.3-linux_x86_64.tar.gz"
      sha256 "80a4884b0cbf39c81fa203ec9da94ebe3ca8396101e05e72d188f7e09b228378"
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
    # The local ARC encoder ships in the macOS arm64 and Linux archives, beside rayline (which looks for it there).
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
