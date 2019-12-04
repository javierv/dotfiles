import System.IO

import XMonad
import XMonad.Config.Kde
import XMonad.Layout.NoBorders
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Util.WindowProperties (getProp32s)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.EZConfig(removeKeysP)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import qualified XMonad.StackSet as W

main = do
  xmonad $ docks $ ewmh $ kde4Config {
      startupHook = do
        setWMName "LG3D"
        spawn "ibus-daemon -drx"
        spawn "xkbset sticky -twokey -latchlock"
    , workspaces = ["dev", "mail", "misc", "music"]
    , manageHook = composeAll . concat $ [
          [className   =? c --> doShift "dev" | c <- ["Firefox"]]
        , [className   =? c --> doShift "mail" | c <- ["Thunderbird"]]
        , [className   =? c --> doFloat | c <- ["plasmashell"]]
        , [className   =? c --> doFloat | c <- ["pcsx"]]
        , [className   =? c --> doFloat | c <- ["gsdx"]]
        , [className   =? c --> doFloat | c <- ["pcsx2"]]
        , [className   =? c --> doFloat | c <- ["PCSX2"]]
        , [className   =? c --> doFloat | c <- ["GSdx"]]
        , [className   =? c --> doFloat | c <- ["mame"]]
        , [className   =? c --> doFloat | c <- ["Yabause"]]
        , [className   =? c --> doFloat | c <- ["mupen64plus"]]
        , [className   =? c --> doIgnore | c <- ["stalonetray"]]
        ]
    , layoutHook = smartBorders (layoutHook kde4Config)
    , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
    , focusedBorderColor = "#444444"
    }
    `additionalKeysP`
    [ ("M-s", spawn "konsole")
    , ("M-b", spawn "firefox")
    , ("M-e", spawn "thunderbird")
    , ("M-x", spawn "lyx")
    , ("M-p", spawn "okular")
    , ("M-r", spawn "krunner")
    , ("M-g", spawn "dolphin")
    , ("M-<Return>", sendMessage NextLayout)
    , ("M-<Space>", windows W.focusDown)
    , ("M-<Backspace>", windows W.focusUp)
    , ("M-m", windows $ W.greedyView "dev")
    , ("M-,", windows $ W.greedyView "mail")
    , ("M-.", kill)
    , ("M-a", spawn "mpc pause")
    , ("M-w", spawn "mpc play")
    , ("M-7", spawn "mpc prev")
    , ("M-8", spawn "mpc next")
    , ("M-<", spawn "mpc seek -10")
    , ("M-z", spawn "mpc seek +10")
    , ("M-+", spawn "mpc volume +5")
    , ("M--", spawn "mpc volume -5")
    , ("M-9", spawn "mpc update && mpc clear && mpc add / && mpc random on && mpc play")
    ]
    `removeKeysP`
    [ "M-j", "M-k", "M-n" ]

kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
    override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
    return $ maybe False (elem $ fromIntegral override) wt
