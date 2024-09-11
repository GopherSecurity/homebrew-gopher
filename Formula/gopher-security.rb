class GopherSecurity < Formula
    desc "Gopher Security application"
    homepage "https://www.gopher.security"
    url "https://s3.amazonaws.com/public.gopher.security/apps/release/darwin/GopherSecurity-darwin-0.0.2-15-amd64-release.pkg"
    sha256 "e0e640d5f8077f6af8026ee7bef9fc90df8b6aabc78164f3713eae70532dc213"
    version "0.0.2-15"
  
    def install
      # Extract the .pkg file
      system "/usr/sbin/pkgutil", "--expand", "#{cached_download}", "#{buildpath}/extracted"
  
      # Install the application bundle
      prefix.install Dir["#{buildpath}/extracted/**/GopherSecurity.app"]
  
      # Create symlinks for executables
      bin.install_symlink "#{prefix}/GopherSecurity.app/Contents/MacOS/gopher_security" => "gopher-security"
    end
  
    def post_install
      # Run any post-installation scripts if necessary
      system "#{prefix}/GopherSecurity.app/Contents/Resources/postinstall" if File.exist? "#{prefix}/GopherSecurity.app/Contents/Resources/postinstall"
    end
  
    def caveats
      <<~EOS
        GopherSecurity has been installed at:
          #{prefix}/GopherSecurity.app
  
        You can start GopherSecurity by running:
          open #{prefix}/GopherSecurity.app
        
        Or by running 'gopher-security' in your terminal.
  
        Note: This installation method does not require sudo, but it may not set up
        all system integrations. If you encounter any issues, you may need to run
        the official installer with sudo privileges.
      EOS
    end
  end