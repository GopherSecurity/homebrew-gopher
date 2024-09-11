class GopherSecurity < Formula
    desc "Gopher Security application"
    homepage "https://www.gopher.security"
    url "https://s3.amazonaws.com/public.gopher.security/apps/release/darwin/GopherSecurity-darwin-0.0.2-15-amd64-release.pkg"
    sha256 "e0e640d5f8077f6af8026ee7bef9fc90df8b6aabc78164f3713eae70532dc213"
    version "0.0.2-15"
  
    def install
      pkg_file = "GopherSecurity-darwin-0.0.2-15-amd64-release.pkg"
      system "sudo", "/usr/sbin/installer", "-pkg", "#{cached_download}", "-target", "/"
      
      # Check if the application was installed
      unless File.exist?("/Applications/GopherSecurity.app")
        opoo "GopherSecurity.app was not found in /Applications after installation."
      end
      
      # Try to find and symlink the main executable
      gopher_exec = Dir.glob("/Applications/GopherSecurity.app/**/gopher").first
      if gopher_exec && File.executable?(gopher_exec)
        bin.install_symlink gopher_exec
      else
        opoo "Could not find or symlink the 'gopher' executable. You may need to run it directly from the Applications folder."
      end
    end
  
    def post_install
      system "pkgutil", "--pkgs | grep -i gopher"
      ohai "Installation complete. If 'gopher' command is not available, try running the application from /Applications/GopherSecurity.app"
    end
  
    def uninstall
      system "sudo", "/Applications/GopherSecurity/uninstallAll"
    end
  
    def caveats
      <<~EOS
        GopherSecurity has been installed to /Applications/GopherSecurity.app
  
        If the 'gopher' command is not found in your terminal, you can:
        1. Run the application directly from /Applications/GopherSecurity.app
        2. Add the application's bin directory to your PATH if available
  
        To uninstall, run:
          brew uninstall gopher-security
  
        Note: This formula requires sudo access to install and uninstall the application.
      EOS
    end
  end