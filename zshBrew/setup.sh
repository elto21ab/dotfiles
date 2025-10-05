#!/usr/bin/env zsh
# 2025-10-02

# ~/.macos — https://mths.be/macos
# Make script executable by running chmod +x setup.sh in Term
# Quit Settings panes; to prevent them overriding our changes
osascript -e 'tell application "System Preferences" to quit'
sudo -v # adm pw upfront
# firefox --ProfileManager
# /Users/e/Library/Application Support/Firefox/Profiles/Ido4p767.Default User

###################### login items #####################
# # Define an array of application paths
# declare -a apps=(
#     "/Applications/Google Drive.app"
#     "/Applications/Raycast.app"
#     "/Applications/TRex.app"
#     "/Applications/BetterTouchTool.app"
# )
# # Generate the AppleScript command to add each app as a login item
# add_login_items_script="tell application \"System Events\""
# for app in "${apps[@]}"; do
#     add_login_items_script+=$'\n'"    make new login item at end with properties {path:\"${app}\", hidden:false}"
# done
# add_login_items_script+=$'\n'"end tell"
# # Execute the AppleScript command
# osascript -e "$add_login_items_script"
##############################################################

###################### defaults domains ######################
# defaults read com.apple.Accessibility
  # com.apple.finder - Finder preferences
  # com.apple.dock - Dock preferences
  # com.apple.screencapture - Screenshot preferences
  # com.apple.systempreferences - System Preferences settings
  # com.apple.Safari - Safari browser settings
  # com.apple.Terminal - Terminal preferences
  # NSGlobalDomain - Global preferences

##############################################################
###################### ERROR HANDLING ######################
# Function to run defaults write with error handling
# run_defaults_write() {
#   domain=$1
#   key=$2
#   value=$3
#   if ! defaults write "$domain" "$key" "$value"; then
#     echo "Failed to write to $domain"
#   fi
# }
# # Example usage
# run_defaults_write com.apple.universalaccess someSetting -bool true

# ================== General ==================
# Set Caps Lock key as Escape <-- Better w/ BTT (low-level) or Raycast (high-level) <-- only use keyboard maestro!
# hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}'

# fix-finder.sh
defaults write com.apple.finder FK_StandardViewSettings -dict-add ListViewSettings '{ "columns" = ( { "ascending" = 1; "identifier" = "name"; "visible" = 1; "width" = 300; }, { "ascending" = 0; "identifier" = "dateModified"; "visible" = 1; "width" = 181; }, { "ascending" = 0; "identifier" = "size"; "visible" = 1; "width" = 97; } ); "iconSize" = 16; "showIconPreview" = 0; "sortColumn" = "name"; "textSize" = 12; "useRelativeDates" = 1; }'
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true" # Remove trash items older than 30 days
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1 # Set sidebar icon size to small
defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true # Show devices section in sidebar
defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true # Show places section in sidebar

# remove-animations.sh
# defaults write com.apple.universalaccess reduceMotion -bool true # Reduce motion in Accessibility
# defaults write NSGlobalDomain NSWindowResizeTime -float 0.001 # Speed up window resize animations
# defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false # Disable smooth scrolling
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false # Disable window animations

defaults write -g QLPanelAnimationDuration -float 0 # Disable Quick Look animations
defaults write com.apple.finder DisableAllAnimations -bool true # Disable Finder animations
defaults write com.apple.dock expose-animation-duration -float 0.1 # Speed up Mission Control animations
defaults write com.apple.dock springboard-show-duration -float 0.1 # Speed up Launchpad show animation
defaults write com.apple.dock springboard-hide-duration -float 0.1 # Speed up Launchpad hide animation

defaults write com.apple.mail DisableReplyAnimations -bool true # Disable Mail reply animations
defaults write com.apple.mail DisableSendAnimations -bool true # Disable Mail send animations
# defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true # Disable text field zoom animations

# system-cleanup.sh
defaults write com.apple.CloudSubscriptionFeatures.optIn "545129924" -bool "false" # Disable Apple Intelligence features

# key repeat rate (Old)
defaults write NSGlobalDomain KeyRepeat -int 1; #0
defaults write NSGlobalDomain InitialKeyRepeat -int 15; #5
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true; #false
# key repeat rate (new)
defaults write com.apple.Accessibility KeyRepeatDelay -float 0.25 # 0.004      # 0.01
defaults write com.apple.Accessibility KeyRepeatInterval -float 0.17 # 0.002   # 0.001

defaults write com.apple.HIToolbox AppleKeyboardUIMode -int  3

defaults write -g AppleInterfaceStyle -string "Dark"
# spacing between menu bar icons
# defaults -currentHost write -globalDomain NSStatusItemSpacing -int 10

# Increase sound quality for Bluetooth headphones/headsets
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Default terminal = ghosty.app
# Default web browser = zen-browser.app
# Display virtual size = "More Space" (through display resolution settings) 

# Screenshot fix
defaults write com.apple.screencapture "type" -string "heic"
defaults write com.apple.screencapture name "screen"
defaults write com.apple.screencapture location ~/Downloads/
# defaults write com.apple.screencapture location ~/Pictures/
# defaults write com.apple.screencapture "include-date" 0

##############################################################
########################## Boot, Sleep, & Startup ############
##############################################################
# Disable the startup noise on boot
# sudo nvram SystemAudioVolume=%01 # indtead of {=" "}
sudo nvram SystemAudioVolume={" "} # indtead of %01
# Require pw immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# Disable machine sleep while charging
sudo pmset -c sleep 0

#When switching applications, switch to respective space <-- doesn't work? 25W20
# defaults write -g AppleSpacesSwitchOnActivate -bool true

##############################################################
########################## Sys Annoyance #####################
##############################################################

# ================== AUTO WARNINGS ==================

# General: Disable the "warn before quitting" dialog (for apps that support this key, like Safari)
# defaults write com.apple.Safari WarnAboutQuitting -bool false

# Disable the warning when emptying Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# Disable “Are you sure you want to open this app?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Auto quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
# Prevent Time Machine asking to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
defaults write com.apple.CrashReporter DialogType -string "none"          # Disable the crash reporter

# Prevent Photos from opening automatically when devices are plugged in.
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
# Stop iTunes from responding to the keyboard media keys.
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# ================== Mac APP STORE ==================
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true  # Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1          # Download available updates in background
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1      # Install System data files & security updates
defaults write com.apple.commerce AutoUpdate -bool true                   # Turn on app auto-update

##############################################################
########################## Periferalls (BT & KVM) input ######                 
##############################################################

# ================== Trackpad ==================
# Tap to click.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Y 2nd time: Enable three-finger drag 
# Note: Might not work on all macOS vers. or conf. due to sys. accessibility pref.
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

defaults write com.apple.universalaccess MousePickerModeOn -bool true           # Enable shake mouse pointer to locate
# Maximize windows on double clicking them
# defaults write -g AppleActionOnDoubleClick 'Maximize'

# ================== KEYBOARD ==================
# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true   # Follow mouse/kb focus while zoomed in
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false  # Disable auto-correct.
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false      # Disable text-completion.
# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2                        # previously 3; don't know why

##############################################################
########################## UI/UX #############################
##############################################################
defaults write NSGlobalDomain AppleInterfaceStyle Dark                          # Dark menubar/dock

# ================== Wallpaper ==================
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Black.png"'
# Set custom wallpaper img. `DefaultDesktop.jpg` is already a symlink, and all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

# ================== SPOTLIGHT ==================
# Remove spotlight
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
# Disable spotlight shortcut
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add  64 "{
#   enabled =  0;
#   value = {
#     parameters = (65535,  49,  1048576);
#     type = 'standard';
#   }; 
# }"

# ================== MISSION CONTROL ==================
# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.01
# Don’t auto rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# ================== DOCK ==================
# Y: Set the Dock to auto-hide and position it on the left
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -int 16                        # Set the Dock size to minimum
defaults write com.apple.dock largesize -int 96                       # Max magnification size
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock autohide-delay -float 0                 # Remove auto-hiding Dock delay
defaults write com.apple.dock autohide-time-modifier -float 0         # Remove animation when hiding/showing the Dock

# Add a spacer to the left side of Dock (where the apps are)
# defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of Dock (where the Trash is)
# defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Only useful when setting up a new Mac, or if you don’t use the Dock to launch apps.
# defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock static-only -bool true                  # Show only open apps in the Dock
defaults write com.apple.dock show-recents -bool false                # Don’t show recent applications in Dock
defaults write com.apple.dock show-process-indicators -bool true      # Show indicator lights for open apps in Dock:
defaults write com.apple.dock showhidden -bool true                   # hidden applications translucent in dock
defaults write com.apple.dock launchanim -bool false                  # Don’t animate opening applications from the Dock
defaults write com.apple.dock autohide -bool true                     # Automatically hide and show the Dock
# Disable the delay when hovering over the toolbar title view
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"
defaults write com.apple.dock "scroll-to-open" -bool "true"           # mouse scroll over dock app to exposé app windows

##############################################################
########################## System Preferences > Control Centre
##############################################################

# ================== Menubar ==================
# Hide remaining battery time; show percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
# Control Centre Modules (CCM) > Bluetooth > Show in Menu Bar
defaults write "com.apple.controlcenter" "NSStatusItem Visible Bluetooth" -bool true
# CCM > Now Playing > Don't Show in Menu Bar
defaults write "com.apple.airplay" "NSStatusItem Visible NowPlaying" -bool false

# CCM > Screen Mirroring > Don't Show in Menu Bar
defaults write "com.apple.airplay" showInMenuBarIfPresent -bool false
# CCM > Sound > Always Show in Menu Bar
defaults write "com.apple.controlcenter" "NSStatusItem Visible Sound" -bool false
# Menu Bar Only > Clock Options > Show Date: Never
# defaults write "com.apple.menuextra.clock" ShowDate -int 2
# Menu Bar Only > Clock Options > Show the day of a week
defaults write "com.apple.menuextra.clock" ShowDayOfWeek -bool true
# Menu Bar Only > Spotlight > Don't Show in Menu Bar
defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1

##############################################################
########################## Mail.app ##########################                                                    
##############################################################
defaults write com.apple.mail DisableReplyAnimations -bool true         # Disable send and reply animations in Mail.app
defaults write com.apple.mail DisableSendAnimations -bool true
# Copy email address as `foo@example.com` instead of `Foo Bar <foo@example.com>`
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"
# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

##############################################################
########################## Finder ############################
##############################################################

# ================== Desktop ==================
plist_file="${HOME}/Library/Preferences/com.apple.finder.plist"

# related to icons on desk, and everywhere else
# 1-3   Show item info near icons
# 4-6   Enable snap-to-grid
# 7-9   Incr. grid spacing
# 10-13 Incr. the size
sudo /usr/libexec/PlistBuddy \
  -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" \
  -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" \
  -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" \
  -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" \
  -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" \
  -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" \
  -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" \
  -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" \
  -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" \
  -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" \
  -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" \
  -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" \
  "${plist_file}"
################################################################

# ================== Windows/panes ==================
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int  2              # Set sidebar icon size to large
defaults write com.apple.finder ShowStatusBar -bool true                      # Show status bar in Finder
defaults write com.apple.finder ShowPathbar -bool true                        # Finder: show path bar
defaults write NSGlobalDomain AppleShowAllExtensions -bool true               # show all filename extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false    # Disable file extension change warning 
defaults write com.apple.finder QuitMenuItem -bool true                       # Allow ⌘+Q Finder; also hide desk icons
defaults write com.apple.finder QLEnableTextSelection -bool true              # Allow text selection in Quick Look
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true            # Display full POSIX path in window title
defaults write com.apple.finder _FXSortFoldersFirst -bool true                # Folders on top 1st
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"   # Folders on top 2nd

defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false # Disable the warning before removing from iCloud Drive
# Security: Allow accessories to connect = Automatically When Unlocked
defaults write com.apple.security.authorizationhost touchid.rules.system.preferences.security.remoted -string "allow"

# General: Prefer tabs when opening documents = Always
# defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"

# In List View, group by Kind and sort by Name
# This sets the default for all windows.
defaults write com.apple.finder FXArrangeGroupViewBy -string "Kind"
defaults write com.apple.finder FXArrangeSortViewBy -string "Name"

# Use list view in all Finder windows by default
# 4-letter codes for view modes: `icnv`, 'Nlsv' `clmv`, `glyv` <-- glitchy 25W20 ==> use yazi or IDE instead
# defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
# defaults write com.apple.finder FXPreferredViewStyle Nlsv

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Set search scope.
# This Mac       : `SCev`
# Current Folder : `SCcf`
# Previous Scope : `SCsp`
defaults write com.apple.finder FXDefaultSearchScope SCcf
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Set default path for new windows.
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other…       : `PfLo`
defaults write com.apple.finder NewWindowTarget PfDo

##############################################################
## Kill affected apps: Apply the changes by restarting apps ##
##############################################################
for app in "Activity Monitor" \
	"Mail" \
  "Finder" \
  "Dock" \
  "App Store" \
	"SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done
echo "Done! Some changes require a restart."
