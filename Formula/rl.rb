class Rl < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+c9852304cc72/homebrew/rl-0.1.0-macosx_11_0_arm64.tar.gz"
      sha256 "e4c326bed99d5bc0648a2e70d67fd5da74688d6e44f95426941d114bbc767e6a"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+c9852304cc72/homebrew/rl-0.1.0-macosx_10_12_x86_64.tar.gz"
      sha256 "dfeb2ff22af0d2d2c6fe2d4c4c4ca150b3fdeb6671126d15206b17f59f0f8a37"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.1.0+c9852304cc72/homebrew/rl-0.1.0-linux_aarch64.tar.gz"
      sha256 "577547a890aacfb2a8bb5725113df4ea240b919b7cadb5cc52aa6d15faed2f47"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.1.0+c9852304cc72/homebrew/rl-0.1.0-linux_x86_64.tar.gz"
      sha256 "be84687e2277eb04e075d505f8115d60c423f2625fa2a6c077ef510bf048c8d1"
    end
  end

  livecheck do
    url "https://get.rayline.ai/cli/latest.json"
    regex(/"version"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  def install
    bin.install "rl"
    bin.install "rld"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rl --version")
    assert_match "rld", shell_output("#{bin}/rld --version")
  end
end
