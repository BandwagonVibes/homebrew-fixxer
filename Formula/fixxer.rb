class Fixxer < Formula
  include Language::Python::Virtualenv

  desc "AI-powered photography workflow automation"
  homepage "https://github.com/BandwagonVibes/fixxer"
  url "https://github.com/BandwagonVibes/fixxer/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "192d7c34bd1481de4258c83b7ee34c57b7fe62ee21a51e4965974eb7986f240a"
  license "MIT"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12", system_site_packages: false)
    system libexec/"bin/python", "-m", "ensurepip"
    system libexec/"bin/python", "-m", "pip", "install", "-U", "pip"
    system libexec/"bin/pip3", "install", "-r", "requirements.txt"
    system libexec/"bin/pip3", "install", ".", "--no-deps"
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
