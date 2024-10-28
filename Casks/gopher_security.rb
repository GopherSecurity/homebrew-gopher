cask "gopher_security" do
    version "0.0.2-31"
    sha256 "9534ec05b689d22ef0a66c113484f4a4e75011386f975b2da3dd491fd08e3539"
  
    url "https://download.gopher.security/apps/release/darwin/GopherSecurity-darwin-#{version}-amd64-release.pkg"
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
        brew uninstall gopher_security
      You may need to restart your computer for all changes to take effect.
    EOS
  end
  