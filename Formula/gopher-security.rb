class GopherSecurity < Formula
    desc "Gopher Security application"
    homepage "https://www.gopher.security"
    url "https://s3.amazonaws.com/public.gopher.security/apps/release/darwin/GopherSecurity-darwin-0.0.2-15-amd64-release.pkg"
    sha256 "e0e640d5f8077f6af8026ee7bef9fc90df8b6aabc78164f3713eae70532dc213"
    version "0.0.2-15"
  
    def install
      # Extract the .pkg file
      system_command! "/usr/sbin/pkgutil",
        args: ["--expand", "#{cached_download}", "#{buildpath}/extracted"],
        verbose: true
  
      # Check if extraction was successful
      extracted_path = Pathname.new("#{buildpath}/extracted")
      raise "Failed to extract package contents" unless extracted_path.directory?
  
      # Find the .app directory
      app_dir = Pathname.glob("#{extracted_path}/**/*.app").first
      raise "Could not find .app directory in extracted contents" if app_dir.nil?
  
      # Install the application bundle
      prefix.install app_dir
  
      # Create symlinks for executables
      executable_path = "#{prefix}/#{app_dir.basename}/Contents/MacOS/gopher_security"
      if File.executable?(executable_path)
        bin.install_symlink executable_path => "gopher-security"
      else
        opoo "Executable 'gopher_security' not found in the expected location"
      end
    end
  
    def post_install
      app_path = "#{prefix}/GopherSecurity.app"
      if File.directory?(app_path)
        system_command "/usr/bin/xattr",
          args: ["-rd", "com.apple.quarantine", app_path],
          sudo: true
      end
    end
  
    def caveats
      <<~EOS
        GopherSecurity has been installed at:
          #{prefix}/GopherSecurity.app
  
        You can start GopherSecurity by running:
          open #{prefix}/GopherSecurity.app
        
        Or by running 'gopher-security' in your terminal.
  
        If you encounter any issues, please try the following:
        1. Ensure you have the necessary permissions to run the application.
        2. If the application doesn't start, try running the official installer with sudo privileges.
  
        For support, please contact Gopher Security support team.
      EOS
    end
  end