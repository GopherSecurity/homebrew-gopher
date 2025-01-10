cask "gopher_security_app" do
    version "0.0.2-35"
    sha256 "9559b8f78d00afd78ba736b5b9812c7c6c9e8e309b7e706469ea11f8102a8e91"
  
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
        brew uninstall gopher_security_app
      You may need to restart your computer for all changes to take effect.
    EOS
  end
  