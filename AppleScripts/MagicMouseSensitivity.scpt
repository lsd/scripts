-- Isam Machlovi http://github.com/lsd
-- 09/07/2013 8:58 PM current song Miss Mars by 80kidz

-- Description
--  Applescript to adjust mouse sensitivity to 100% (10.0)
--  Useful if you switch between mice simultaneously connected
--  to your mac (gamers.) I use a Magic Mouse and a Razer Orochi 2013
--  and find my Magic Rat sensitivity is always set to low after I use
--  the Orochi and after screensaver / re-logging in.

-- Caveats
--  I have a fast machine so the delays are set low. Try 0.2 - 0.3
--  if you encounter issues (i.e., trying to click 'Mouse' before
--  sys prefs has loaded)
--  Also, HOW I access sys preferences (keystroke ","…) is likely 
--  to differ is unlikely to exist on your machine.

-- Licensed under WTFPL

tell application "System Events"
  click UI element "Finder" of list 1 of application process "Dock"

  delay 0.12
  -- This is a universal short key I use to open system preferences from Finder
  keystroke "," using {control down, command down}

  delay 0.12
  click UI element "Mouse" of scroll area 1 of window "System Preferences" of application process "System Preferences"

  delay 0.09
  click value indicator 1 of slider 1 of tab group 1 of window "Mouse" of application process "System Preferences"
  tell slider 1 of tab group 1 of window "Mouse" of application process "System Preferences"
    set value to 10.0
  end tell

  delay 0.05
  click UI element 1 of window "Mouse" of application process "System Preferences"
end tell
