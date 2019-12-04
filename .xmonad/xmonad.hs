import System.IO

import XMonad
import XMonad.Config.Kde
import XMonad.Layout.NoBorders
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Util.WindowProperties (getProp32s)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.EZConfig(additionalKeys)
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
    , ("M-w", spawn "xrandr | grep '900x1440+0+0 left' > /dev/null && xrandr --output VGA1 --rotate normal --mode 1440x900 || xrandr --output VGA1 --rotate left --mode 1440x900")
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
    ]
    `additionalKeys`
    [ ((mod4Mask, xK_c), spawn "mpc pause")
    , ((mod4Mask, xK_b), spawn "mpc next")
    , ((mod4Mask, xK_z), spawn "mpc prev")
    , ((mod4Mask, xK_v), spawn "mpc play")
    , ((mod4Mask, xK_l), spawn "mpc seek +10")
    , ((mod4Mask, xK_h), spawn "mpc seek -10")
    , ((mod4Mask, xK_plus), spawn "mpc volume +5")
    , ((mod4Mask, xK_minus), spawn "mpc volume -5")
    , ((mod4Mask, xK_r), spawn "mpc update && mpc clear && mpc add / && mpc random on && mpc play")
    , ((mod4Mask, xK_p), spawn "kquitapp5 plasmashell ; /usr/bin/plasmashell --shut-up ; /usr/bin/plasmashell")
    ]
    `removeKeysP`
    [ "M-j", "M-k", "M-n" ]

kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
    override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
    return $ maybe False (elem $ fromIntegral override) wt
