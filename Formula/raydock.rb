class Raydock < Formula
  desc "Raydock on-device CLI for local models and cloud services"
  homepage "https://rayline.ai"
  version "0.4.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.4+e91fc97aabe5/homebrew/rayline-0.4.4-macosx_11_0_arm64.tar.gz"
      sha256 "551d7ff710576ad7b89b8704e3be41a30f7db4a8c73fb965d301563da6c1dedd"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.4+e91fc97aabe5/homebrew/rayline-0.4.4-macosx_10_12_x86_64.tar.gz"
      sha256 "db2221e2b13ff7f0115f767ebbcceb86cc9ddf7cc9c8a07674303c9ee0386069"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.4.4+e91fc97aabe5/homebrew/rayline-0.4.4-linux_aarch64.tar.gz"
      sha256 "8568fb67e5b5ebb16e2b76bd674693a0971df7892226bcc480cc229f6d3a5810"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.4.4+e91fc97aabe5/homebrew/rayline-0.4.4-linux_x86_64.tar.gz"
      sha256 "7dcfc80f78a55eb209e5e021db731125a490f5b171c6f27cc957fbc723f94ad2"
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
