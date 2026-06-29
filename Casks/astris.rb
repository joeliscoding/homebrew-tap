# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "astris" do
  version "1.0.16,0e933ae41"
  sha256 "538d028bf86f5d965367892b7a384c7abbc307c442c403209bfaddbe2e6e518f"

  url "https://github.com/V380-Ori/Astris.Binaries/releases/download/astris-#{version.csv.first}/Astris-#{version.csv.first}%2B#{version.csv.second}.dmg"
  name "Astris"
  desc "A Nintendo Switch 1 emulator based on Ryujinx for Apple silicon Macs"
  homepage "https://github.com/V380-Ori/Astris.Binaries"

  livecheck do
    url :url
      strategy :github_releases do |releases|
        releases.map do |release|
          next if release["assets"].blank?

          release["assets"].map do |asset|
            match = asset["name"]&.match(/^Astris[._-]v?(\d+(?:\.\d+)+)\+([a-f0-9]+)\.dmg$/i)
            next if match.blank?

            "#{match[1]},#{match[2]}"
          end
        end.flatten.compact
      end
    end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Astris.app"

  zap trash: [
    "~/Library/Application Support/Astris",
    "~/Library/Preferences/com.v380-ori.Astris.plist",
    "~/Library/Saved Application State/com.v380-ori.Astris.savedState",
  ]
end
