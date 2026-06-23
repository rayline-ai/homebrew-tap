class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.0/homebrew/rayline-0.2.0-macosx_11_0_arm64.tar.gz"
      sha256 "0be7112b0a9fd33557f927b6074e82ca66f75743b5a709354eb9d390c184ef1d"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.0/homebrew/rayline-0.2.0-macosx_10_12_x86_64.tar.gz"
      sha256 "05544df7a3399b652d45cf2b0f20f4884c4f5a260d937d412a056a42601de33f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.0/homebrew/rayline-0.2.0-linux_aarch64.tar.gz"
      sha256 "07bc98315ebb6c14cfb4687c7d99db95973674d3e4dcb0cfe5859f7ecece25cf"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.0/homebrew/rayline-0.2.0-linux_x86_64.tar.gz"
      sha256 "bd2f9a6a0e3b40711587c18881a0cf665ac0ad6f4d0f0731ecb18d4f155514c4"
    end
  end

  livecheck do
    url "https://get.rayline.ai/cli/latest.json"
    regex(/"version"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  def install
    bin.install "rayline"
    bin.install "rld"
  end

  def caveats
    <<~EOS
      Run `rayline claude --local-router` to launch Claude Code through Rayline.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rayline --version")
    assert_match "rld", shell_output("#{bin}/rld --version")
  end
end
