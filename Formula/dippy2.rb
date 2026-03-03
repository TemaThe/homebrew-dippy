class Dippy2 < Formula
  desc "Auto-approve safe shell commands for AI coding assistants (fork with script unfolding)"
  homepage "https://github.com/TemaThe/Dippy2"
  url "https://github.com/TemaThe/Dippy2.git", branch: "main"
  version "0.2.6-fork"
  license "MIT"

  depends_on "python"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/dippy-hook" => "dippy2"
    bin.install_symlink libexec/"bin/dippy-statusline" => "dippy2-statusline"
  end

  def caveats
    <<~EOS
      Add to ~/.claude/settings.json:

        {
          "hooks": {
            "PreToolUse": [
              {
                "matcher": "Bash",
                "hooks": [{ "type": "command", "command": "dippy2" }]
              }
            ]
          }
        }

      For configuration and fork-specific features:
        https://github.com/TemaThe/Dippy2
    EOS
  end

  test do
    input = '{"tool_name": "Bash", "tool_input": {"command": "ls"}}'
    output = pipe_output(bin/"dippy2", input)
    assert_match "allow", output
  end
end
