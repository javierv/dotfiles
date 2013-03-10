import System.IO

import XMonad
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers --doFullFloat, isFullScreen, ...
import XMonad.Hooks.ManageDocks -- avoidStruts: stalonetray, xmobar
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)

main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad $ defaultConfig {
      startupHook = do
        spawn "stalonetray --max-geometry 7x1-0+0 --icon-size 16"
        spawn "xmobar ~/.xmonad/xmobarrc"
        spawn "nm-applet" -- Network Manager: WLAN.
    , workspaces = ["1:dev", "2:mail", "3:misc", "4:music"]
    , manageHook = manageDocks <+> manageHook defaultConfig
        <+> (composeOne [ isFullscreen -?> doFullFloat])
        <+> (composeAll . concat $ [
          [className   =? c --> doShift "2:mail" | c <- ["Thunderbird"]]
        , [className   =? c --> doShift "4:music" | c <- ["Amarok"]]
        , [className   =? c --> doShift "1:dev" | c <- ["Firefox"]]
        , [className   =? c --> doFloat | c <- ["mame"]]
        , [className   =? c --> doFloat | c <- ["pcsx"]]
        , [className   =? c --> doIgnore | c <- ["stalonetray"]]
        ])
    , layoutHook = avoidStruts $ smartBorders (layoutHook defaultConfig)
    , logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "green" "" . shorten 50
                }
    }
    `additionalKeysP`
    [ ("M-a", spawn "amarok")
    , ("M-c", spawn "konsole")
    , ("M-b", spawn "chromium-browser")
    , ("M-m", spawn "thunderbird")
    , ("M-w", spawn "twinkle")
    , ("M-x", spawn "lyx")
    ]
