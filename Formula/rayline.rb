class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.1.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.1+ecdd9d418171/homebrew/rayline-0.1.1-macosx_11_0_arm64.tar.gz"
      sha256 "a761570c8576069c05e2e800473d021025b633ee8a238c3994515ac658f1bae1"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.1+ecdd9d418171/homebrew/rayline-0.1.1-macosx_10_12_x86_64.tar.gz"
      sha256 "f3cb5a5d12e7f8386c543bd5ce9c042a09be388f584e25711b2fcbf9ea6aaa83"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.1+ecdd9d418171/homebrew/rayline-0.1.1-linux_aarch64.tar.gz"
      sha256 "1db678723d5d6c445432ff9efe721aa1ef89b133c393e39e007992c5b8eeea9d"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.1+ecdd9d418171/homebrew/rayline-0.1.1-linux_x86_64.tar.gz"
      sha256 "b2a8cc46d96897a69eda716a835583e577b314837547b2291f6ddb6e4a9f3acd"
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
      Run `rayline claude` to launch Claude Code through Rayline.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rayline --version")
    assert_match "rld", shell_output("#{bin}/rld --version")
  end
end
