# Some stuff was taken from
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# This originally from https://github.com/paulmillr/dotfiles

echo '=========='
echo 'Tweak OSX settings to a certain liking.'
echo '=========='

echo 'Tweak settings? This will change a lot of things. The majority will not ask for confirmation.'
printf '(y/n) [n] '
read should_tweak_settings
if [[ $should_tweak_settings != 'y' ]]; then
  echo 'No changes made.'
  return 0
fi

echo 'Beginning...'

echo 'Reveal IP Address, hostname, OS version, etc when clicking the clock in the login window'
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo 'Check for software updates daily, not just once per week'
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo 'Require password immediately after sleep'
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo 'Save screenshots to $HOME/Documents/Screenshots/'
defaults write com.apple.screencapture location "$HOME/Documents/Screenshots/"

echo 'Disable sound effects on boot'
sudo nvram SystemAudioVolume=0

echo 'Trackpad: enable tap to click for this user and for the login screen'
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sudo defaults write com.apple.AppleMultitouchTrackpad Clicking 1

echo 'Disable auto-correct'
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo ''
echo 'SSD (solid state drive)'
echo '=='

echo 'Prevent Time Machine from prompting to use new hard drives as backup volume'
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo 'Disable local Time Machine snapshots'
sudo tmutil disablelocal

echo 'Disable hibernation (speeds up entering sleep mode)'
sudo pmset -a hibernatemode 0

echo 'Disable the sudden motion sensor as it’s not useful for SSDs'
sudo pmset -a sms 0

echo ''
echo 'Finder'
echo '==='

echo 'Show filename extensions'
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo 'Disable warning on file extension change'
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo 'Disable disk image verification'
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo 'When performing a search, search the current folder by default'
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo 'Disable the warning before emptying the Trash'
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo 'Show the ~/Library folder'
chflags nohidden ~/Library

echo ''
echo 'Safari'
echo '==='

echo 'Set Safari’s home page to `about:blank` for faster loading'
defaults write com.apple.Safari HomePage -string "about:blank"

echo 'Prevent Safari from opening ‘safe’ files automatically after downloading'
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo 'Hide Safari’s bookmarks bar by default'
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo 'Enable the Develop menu and the Web Inspector in Safari'
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo ''
echo 'Spotlight'
echo '==='

echo 'Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed before.'
echo 'Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.'
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

echo 'Set searchable filetypes'
defaults write com.apple.spotlight orderedItems -array \
        '{"enabled" = 1;"name" = "APPLICATIONS";}' \
        '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
        '{"enabled" = 1;"name" = "DIRECTORIES";}' \
        '{"enabled" = 1;"name" = "PDF";}' \
        '{"enabled" = 0;"name" = "FONTS";}' \
        '{"enabled" = 0;"name" = "DOCUMENTS";}' \
        '{"enabled" = 0;"name" = "MESSAGES";}' \
        '{"enabled" = 0;"name" = "CONTACT";}' \
        '{"enabled" = 0;"name" = "EVENT_TODO";}' \
        '{"enabled" = 0;"name" = "IMAGES";}' \
        '{"enabled" = 0;"name" = "BOOKMARKS";}' \
        '{"enabled" = 0;"name" = "MUSIC";}' \
        '{"enabled" = 0;"name" = "MOVIES";}' \
        '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
        '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
        '{"enabled" = 0;"name" = "SOURCE";}'

echo 'Rebuild index? This will take a long time. (y/n) [y] '
read should_rebuild_index
if [[ $should_rebuild_index == 'y' || -z $should_rebuild_index ]]; then
  echo 'Rebuilding index...'
  # Load new settings before rebuilding the index
  killall mds > /dev/null 2>&1
  # Make sure indexing is enabled for the main volume
  sudo mdutil -i on / > /dev/null
  # Rebuild the index from scratch
  sudo mdutil -E / > /dev/null
fi

echo ''
echo 'Memory management'
echo '==='

echo 'Disable swap file. OS X will crash if mem will exceed max mem.'
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist

echo 'Enable swap back.'
# sudo launchctl load -wF /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist

echo ''
echo 'Complete.'
