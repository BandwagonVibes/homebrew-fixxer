class Fixxer < Formula
  include Language::Python::Virtualenv

  desc "AI-powered photography workflow automation"
  homepage "https://github.com/BandwagonVibes/fixxer"
  url "https://github.com/BandwagonVibes/fixxer/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "b733d8938fa729e58868eb10b5b25172dd72e5c9797135a3a1b3d7f47f17be00"
  license "MIT"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    system libexec/"bin/python", "-m", "ensurepip"
    system libexec/"bin/python", "-m", "pip", "install", "-U", "pip"
    system libexec/"bin/pip", "install", "-r", "requirements.txt"
    system libexec/"bin/pip", "install", ".", "--no-deps"
    bin.install_symlink libexec/"bin/fixxer"
  end

  def caveats
    <<~EOS
      FIXXER requires Ollama for AI features:
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
