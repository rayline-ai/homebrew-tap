class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.13"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.13+997c125db4d7/homebrew/rayline-0.2.13-macosx_11_0_arm64.tar.gz"
      sha256 "446ae7cf989c48e57ef63f4c380868f7a23b6cd87f8c8d7ad42c67b03b16883c"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.13+997c125db4d7/homebrew/rayline-0.2.13-macosx_10_12_x86_64.tar.gz"
      sha256 "3aa2803418e118aa0eba16e0ffd07559df24cb813300d5f12e9d5e930766c411"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.13+997c125db4d7/homebrew/rayline-0.2.13-linux_aarch64.tar.gz"
      sha256 "598284322a8d52abfc8249c2b00b0b4e2b7407a8fc60806b5c3a76c844f350a9"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.13+997c125db4d7/homebrew/rayline-0.2.13-linux_x86_64.tar.gz"
      sha256 "20541c9b539fd957fd37a4c8c50c0c5f41b40a79b1f226dd39cb9e317e071b19"
    end
  end

  livecheck do
    url "https://get.rayline.ai/cli/latest.json"
    regex(/"version"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  def install
    bin.install "rayline"
    bin.install "rld"
    # Hybrid execution core: rayline resolves it next to its own executable.
    bin.install "rayline-core"
    pkgshare.install "rayline-core-LICENSE"
    pkgshare.install "rayline-core-source.json"
  end

  def caveats
    <<~EOS
      Run `rayline claude --local-router` to launch Claude Code through Rayline.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rayline --version")
    assert_match "rld", shell_output("#{bin}/rld --version")
    assert_path_exists bin/"rayline-core"
    assert_path_exists pkgshare/"rayline-core-LICENSE"
    # The Go core needs macOS 13+; the Rust CLI still supports older macOS.
    if OS.linux? || MacOS.version >= :ventura
      assert_match "contract_version", shell_output("#{bin}/rayline-core --version")
    end
  end
end
