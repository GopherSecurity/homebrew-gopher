class GopherSecurity < Formula
    desc "Gopher Security application"
    homepage "https://www.gopher.security"
    url "https://s3.amazonaws.com/public.gopher.security/apps/release/darwin/GopherSecurity-darwin-0.0.2-15-amd64-release.pkg"
    sha256 "e0e640d5f8077f6af8026ee7bef9fc90df8b6aabc78164f3713eae70532dc213"
    version "0.0.2-15"
  
    def install
      pkg_name = "GopherSecurity-darwin-0.0.2-15-amd64-release.pkg"
      system "sudo", "/usr/sbin/installer", "-pkg", "#{cached_download}", "-target", "/"
    end
  
    def uninstall
      system "sudo", "/Applications/GopherSecurity/uninstallAll"
    end
  
    def caveats
      <<~EOS
        GopherSecurity has been installed.
        To uninstall, run:
          brew uninstall gopher-security
        You may need to restart your computer for all changes to take effect.
      EOS
    end
  end