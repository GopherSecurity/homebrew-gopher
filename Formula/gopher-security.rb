class GopherSecurity < Formula
    desc "Description of your app"
    homepage "https://www.gopher.security"
    url "https://s3.amazonaws.com/public.gopher.security/apps/release/darwin/GopherSecurity-darwin-0.0.2-15-amd64-release.pkg"
    sha256 "e0e640d5f8077f6af8026ee7bef9fc90df8b6aabc78164f3713eae70532dc213"
  
    def install
      system "installer", "-pkg", "GopherSecurity-darwin-0.0.2-16-amd64-release.pkg", "-target", "/"
    end

    def uninstall
        system "./Applications/GopherSecurity/uninstallAll"
      end
  end
  