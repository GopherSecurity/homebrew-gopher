class GopherSecurity < Formula
    desc "Gopher Security application"
    homepage "https://www.gopher.security"
    url "https://s3.amazonaws.com/public.gopher.security/apps/release/darwin/GopherSecurity-darwin-0.0.2-15-amd64-release.pkg"
    sha256 "e0e640d5f8077f6af8026ee7bef9fc90df8b6aabc78164f3713eae70532dc213"
    version "0.0.2-15"
  
    def install
      # Force a password prompt by invalidating sudo timestamp
      system "sudo", "-k"
      
      # Use sudo with -S to read the password from stdin
      IO.popen(["sudo", "-S", "/usr/sbin/installer", "-pkg", "#{cached_download}", "-target", "/"], "w") do |io|
        puts "Please enter your password for sudo access:"
        io.puts $stdin.gets.chomp
      end
      
      # Create symlinks for the executables if they exist
      bin.install_symlink "/Applications/GopherSecurity/GopherSecurity.app/Contents/MacOS/gopher_security" => "gopher-security" if File.exist?("/Applications/GopherSecurity/GopherSecurity.app/Contents/MacOS/gopher_security")
      
      # Check for and symlink any additional executables that might be part of your Flutter app
      Dir.glob("/Applications/GopherSecurity/GopherSecurity.app/Contents/MacOS/*").each do |file|
        if File.executable?(file) && !File.directory?(file)
          bin.install_symlink file => File.basename(file).downcase.gsub("_", "-")
        end
      end
    end
  
    def post_install
      system "pkgutil", "--pkgs | grep -i gopher"
      ohai "Installation complete. You can start GopherSecurity by running 'gopher-security' or opening the application from /Applications/GopherSecurity/GopherSecurity.app"
    end
  
    def uninstall
      system "sudo", "-k"  # Invalidate sudo timestamp
      IO.popen(["sudo", "-S", "rm", "-rf", "/Applications/GopherSecurity"], "w") do |io|
        puts "Please enter your password for sudo access to uninstall:"
        io.puts $stdin.gets.chomp
      end
      system "sudo", "pkgutil", "--forget", "gopher.security.app"
    end
  
    def caveats
      <<~EOS
        GopherSecurity has been installed:
        
        - The main application is located at:
          /Applications/GopherSecurity/GopherSecurity.app
        
        - The main executable has been symlinked to #{HOMEBREW_PREFIX}/bin as:
          gopher-security
        
        To start GopherSecurity, you can:
        1. Open /Applications/GopherSecurity/GopherSecurity.app
        2. Run 'gopher-security' in your terminal
  
        To uninstall, run:
          brew uninstall gopher-security
  
        Note: This formula requires sudo access to install and uninstall the application.
        You will be explicitly prompted for your password during these operations.
      EOS
    end
  end