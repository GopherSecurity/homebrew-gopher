cask "gopher-security" do
    version "0.0.2-15"
    sha256 "e0e640d5f8077f6af8026ee7bef9fc90df8b6aabc78164f3713eae70532dc213"
  
    url "https://s3.amazonaws.com/public.gopher.security/apps/release/darwin/GopherSecurity-darwin-#{version}-amd64-release.pkg"
    name "Gopher Security"
    desc "Gopher Security application"
    homepage "https://www.gopher.security"
  
    pkg "GopherSecurity-darwin-#{version}-amd64-release.pkg"
  
    # Use the existing uninstallAll script during uninstallation
    uninstall script: {
      executable: "/Applications/GopherSecurity/uninstallAll",
      sudo:       true,
    }
  
    caveats <<~EOS
      GopherSecurity has been installed.
      To uninstall, run:
        brew uninstall gopher-security
      You may need to restart your computer for all changes to take effect.
    EOS
  end
  