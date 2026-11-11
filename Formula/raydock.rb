class Raydock < Formula
  desc "Raydock on-device CLI for local models and cloud services"
  homepage "https://rayline.ai"
  version "0.4.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.3+86cb4bb70434/homebrew/rayline-0.4.3-macosx_11_0_arm64.tar.gz"
      sha256 "795fbacde665a2c99f2f69a8d3e8c70be56c012e4d07793ff79e887b8d23b640"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.3+86cb4bb70434/homebrew/rayline-0.4.3-macosx_10_12_x86_64.tar.gz"
      sha256 "241bbc6ea84a7ddf53538fd1eee31960506054f7e524af8aa1f764d39d4d5a5c"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.3+86cb4bb70434/homebrew/rayline-0.4.3-linux_aarch64.tar.gz"
      sha256 "7ab87af162454c97da5a923cb4cdbbb0244d4357c4b87cfa81e57ae101ebed9a"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.3+86cb4bb70434/homebrew/rayline-0.4.3-linux_x86_64.tar.gz"
      sha256 "f49e3a242c34dc399f80771a5bab58a9003e8eb776bf7af8561b250675f273cf"
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
