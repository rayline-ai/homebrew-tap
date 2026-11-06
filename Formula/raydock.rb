class Raydock < Formula
  desc "Raydock on-device CLI for local models and cloud services"
  homepage "https://rayline.ai"
  version "0.4.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.1+2abd0dbcc7ee/homebrew/rayline-0.4.1-macosx_11_0_arm64.tar.gz"
      sha256 "dc4178c4cf3bf3210dc4d77ac538c36658bbfdfab6c3eca9561193da27b4ac19"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.1+2abd0dbcc7ee/homebrew/rayline-0.4.1-macosx_10_12_x86_64.tar.gz"
      sha256 "bfd183e84df5339483cceca4f396840ba26a10dc4196e127d91fee476d56dfa8"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.1+2abd0dbcc7ee/homebrew/rayline-0.4.1-linux_aarch64.tar.gz"
      sha256 "e8473af6e6f051ea3b2e4393f221a014a1d99a94534eef919a6c1c4132081de1"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.1+2abd0dbcc7ee/homebrew/rayline-0.4.1-linux_x86_64.tar.gz"
      sha256 "837edf1d121d6dbccc4f65a43afd41310eb73f34274a24de45d1d632eba8c116"
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
