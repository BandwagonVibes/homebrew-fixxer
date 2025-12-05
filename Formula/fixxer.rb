class Fixxer < Formula
  include Language::Python::Virtualenv

  desc "AI-powered photography workflow automation"
  homepage "https://github.com/BandwagonVibes/fixxer"
  url "https://github.com/BandwagonVibes/fixxer/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "ee1fb4a7e33332c88a61206a0550bc05c6c22f2eac354c8eed12cd0d1910b69c"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
    
    # Explicitly install dependencies that pyproject.toml declares
    system libexec/"bin/pip", "install",
           "textual>=0.47.0",
           "rich>=13.7.0",
           "Pillow>=10.0.0",
           "opencv-python>=4.8.0",
           "numpy>=1.24.0",
           "rawpy>=0.19.0",
           "ImageHash>=4.3.1",
           "ExifRead>=3.0.0",
           "requests>=2.31.0",
           "psutil>=5.9.0"
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
