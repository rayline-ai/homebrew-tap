class Rayline < Formula
  desc "Rayline native router launcher"
  homepage "https://rayline.ai"
  version "0.2.14"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.14+0a478d340f13/homebrew/rayline-0.2.14-macosx_11_0_arm64.tar.gz"
      sha256 "b54cd716bce3bbb7817dfcd80fe09570a81643770c4542a4eae8be6be2e0c7fe"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.14+0a478d340f13/homebrew/rayline-0.2.14-macosx_10_12_x86_64.tar.gz"
      sha256 "9a35453d8bea3e7b21b286fc7c4465fb363efcea823e0b76c45e71e406ec55f5"
    end
  end

  on_linux do
    on_arm do
      url "https://get.rayline.ai/cli/v0.2.14+0a478d340f13/homebrew/rayline-0.2.14-linux_aarch64.tar.gz"
      sha256 "d59083c5ad9c49ca0807466880197c4062f654994ec75e58bf84923ef8c25149"
    end

    on_intel do
      url "https://get.rayline.ai/cli/v0.2.14+0a478d340f13/homebrew/rayline-0.2.14-linux_x86_64.tar.gz"
      sha256 "3b523c1ce5c7aa46832888072126ec66522fe1421cb4463ca5a253762d57fc25"
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
