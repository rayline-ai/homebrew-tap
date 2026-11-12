class Raydock < Formula
  desc "Raydock on-device CLI for local models and cloud services"
  homepage "https://rayline.ai"
  version "0.4.5"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.5+20d02f517d01/homebrew/rayline-0.4.5-macosx_11_0_arm64.tar.gz"
      sha256 "45e6d52b6feab6511c64063131be71ace7bc978d67245bdeecd4d74f21549fee"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.5+20d02f517d01/homebrew/rayline-0.4.5-macosx_10_12_x86_64.tar.gz"
      sha256 "b01c1da6aabfe4d998214f5581200fa5ebf1f3d960ac2f8d06d0a63032afdd5d"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.5+20d02f517d01/homebrew/rayline-0.4.5-linux_aarch64.tar.gz"
      sha256 "5ef333b3d21412b19238efb88d8c22c84eed42a74e1981e6b304fd220c081bbf"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.5+20d02f517d01/homebrew/rayline-0.4.5-linux_x86_64.tar.gz"
      sha256 "79814629bb1d2eb5b8215421008bc8466da9d536a421a6f4d13c9e0d017746f4"
    end
  end

  livecheck do
    url "https://get.rayline.ai/cli/latest.json"
    regex(/"version"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  def install
    bin.install "rayline" => "raydock"
    bin.install_symlink "raydock" => "rayline"
    bin.install "rld"
    # Hybrid execution core: rayline resolves it next to its own executable.
    bin.install "rayline-core"
    pkgshare.install "rayline-core-LICENSE"
    pkgshare.install "rayline-core-source.json"
  end

  def caveats
    <<~EOS
      Run `raydock auth login`, then `raydock claude` to launch Claude Code on ARC
      (Sage for the main agent, Swift for subagents). `raydock claude --local`
      uses on-device routing instead.
    EOS
  end

  test do
    assert_match "raydock #{version}", shell_output("#{bin}/raydock --version")
    assert_equal shell_output("#{bin}/raydock --version"), shell_output("#{bin}/rayline --version")
    assert_match "rld", shell_output("#{bin}/rld --version")
    assert_path_exists bin/"rayline-core"
    assert_path_exists pkgshare/"rayline-core-LICENSE"
    # The Go core needs macOS 13+; the Rust CLI still supports older macOS.
    if OS.linux? || MacOS.version >= :ventura
      assert_match "contract_version", shell_output("#{bin}/rayline-core --version")
    end
  end
end
