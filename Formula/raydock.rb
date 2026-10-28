class Raydock < Formula
  desc "Raydock on-device CLI for local models and cloud services"
  homepage "https://rayline.ai"
  version "0.3.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.3.0+050ddf4377f4/homebrew/rayline-0.3.0-macosx_11_0_arm64.tar.gz"
      sha256 "1ea9ab69a85d806d72034f225dc42a302ea620083a7be756a22b330d3ab2f97a"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.3.0+050ddf4377f4/homebrew/rayline-0.3.0-macosx_10_12_x86_64.tar.gz"
      sha256 "7353bc4301aa696b15e12ec0ea7a2751ce3f3011c68514346ae927b3c681acbd"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.3.0+050ddf4377f4/homebrew/rayline-0.3.0-linux_aarch64.tar.gz"
      sha256 "ab88ceff86fa18ffaa5c1bc35a72181dda9cf05fd839f94f4ca0aac40a77a789"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.3.0+050ddf4377f4/homebrew/rayline-0.3.0-linux_x86_64.tar.gz"
      sha256 "4fd4db932874eb8dfa9dd018880ad3189c1484fd129af7eae6483e07d3189c32"
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
