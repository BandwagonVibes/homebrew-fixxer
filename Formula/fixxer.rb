class Fixxer < Formula
  include Language::Python::Virtualenv

  desc "AI-powered photography workflow automation"
  homepage "https://github.com/BandwagonVibes/fixxer"
  url "https://github.com/BandwagonVibes/fixxer/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "44d76e1626c17b7a84e6076ed6972859907de315f9bb6e5ba4e9a9a0aab75d6a"
  license "MIT"

  depends_on "python@3.12"
  # Add these build dependencies just in case compiling wheels (like opencv/rawpy) gets heavy
  depends_on "cmake" => :build 
  depends_on "pkg-config" => :build

  def install
    # 1. Create the virtualenv manually in libexec
    virtualenv_create(libexec, "python3.12")

    # 2. Install dependencies from requirements.txt
    # We force the venv's pip to install what's in your repo
    system libexec/"bin/pip", "install", "-v", "-r", "requirements.txt"

    # 3. Install the package itself (fixxer)
    # We use --no-deps because we just installed them above
    system libexec/"bin/pip", "install", "-v", ".", "--no-deps"

    # 4. Link the 'fixxer' binary to Homebrew's bin directory so it's in the PATH
    bin.install_symlink libexec/"bin/fixxer"
  end

  def caveats
    <<~EOS
      FIXXER requires Ollama for AI features.
      If you haven't installed it yet:
        brew install ollama
        ollama pull qwen2.5vl:3b

      Launch with:
        fixxer
    EOS
  end

  test do
    system "#{bin}/fixxer", "--help"
  end
end
