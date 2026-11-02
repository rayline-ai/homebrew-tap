class Raydock < Formula
  desc "Raydock on-device CLI for local models and cloud services"
  homepage "https://rayline.ai"
  version "0.3.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.3.1+f3f89d9383f9/homebrew/rayline-0.3.1-macosx_11_0_arm64.tar.gz"
      sha256 "1d398223ee8760cb8cf91dc208d87f38bcd604d995d47788b51eaaa58d4361e2"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.3.1+f3f89d9383f9/homebrew/rayline-0.3.1-macosx_10_12_x86_64.tar.gz"
      sha256 "cad1ac649930285dcfecb5aa1c7027e194e90f2ad5a83859dd2feeb27c05806f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.3.1+f3f89d9383f9/homebrew/rayline-0.3.1-linux_aarch64.tar.gz"
      sha256 "b22c9813986368c037bbf4c431ef1ad3a1f5307b7882e1466d4f77f663bc2c9f"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.3.1+f3f89d9383f9/homebrew/rayline-0.3.1-linux_x86_64.tar.gz"
      sha256 "6bfa2f1f0fac4fa1c3c9eaf3274b9e23a6a6bc3525d28964d1b5f3a17d7e9097"
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
