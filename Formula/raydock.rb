class Raydock < Formula
  desc "Raydock on-device CLI for local models and cloud services"
  homepage "https://rayline.ai"
  version "0.4.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.2+cd11a0bdc1e2/homebrew/rayline-0.4.2-macosx_11_0_arm64.tar.gz"
      sha256 "15eb3da1141f05966adad33dff3248a0232fa92ef1c99ee33047bd6b36e11342"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.2+cd11a0bdc1e2/homebrew/rayline-0.4.2-macosx_10_12_x86_64.tar.gz"
      sha256 "6d6b9f7f97f6d01d0c6d336685785726c150482b13d932764ba9a57de23ce4f0"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.2+cd11a0bdc1e2/homebrew/rayline-0.4.2-linux_aarch64.tar.gz"
      sha256 "fcacf73e6d6141eca9b78741da544858c338162e5abcbb28f0579d17b63fb043"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.2+cd11a0bdc1e2/homebrew/rayline-0.4.2-linux_x86_64.tar.gz"
      sha256 "b99ba5bb927a2a05cf6d6b8e4504a58839578e99b1d03047e1e59844ce7eed00"
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
