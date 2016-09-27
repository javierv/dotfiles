import System.IO

import XMonad
import XMonad.Config.Kde
import XMonad.Layout.NoBorders
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Util.WindowProperties (getProp32s)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.EZConfig(additionalKeys)

main = do
  xmonad $ kde4Config {
      startupHook = do
        setWMName "LG3D"
        spawn "ibus-daemon -drx"
    , workspaces = ["1:dev", "2:mail", "3:misc", "4:music"]
    , manageHook = ((className =? "krunner") >>= return . not --> manageHook kde4Config)
        <+> (kdeOverride --> doFloat)
        <+> (composeOne [ isFullscreen -?> doFullFloat])
        <+> (composeAll . concat $ [
          [className   =? c --> doShift "2:mail" | c <- ["Thunderbird"]]
        , [className   =? c --> doShift "1:dev" | c <- ["Firefox"]]
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
        ])
    , layoutHook = smartBorders (layoutHook kde4Config)
    , focusedBorderColor = "#444444"
    }
    `additionalKeysP`
    [ ("M-c", spawn "konsole")
    , ("M-b", spawn "firefox")
    , ("M-m", spawn "thunderbird")
    , ("M-r", spawn "xmonad --restart")
    , ("M-f", spawn "xsel | iconv -f UTF8 -t UTF16 | xvkbd -utf -file -")
    , ("M-w", spawn "xrandr | grep '900x1440+0+0 left' > /dev/null && xrandr --output VGA1 --rotate normal --mode 1440x900 || xrandr --output VGA1 --rotate left --mode 1440x900")
    , ("M-x", spawn "anki")
    , ("M-o", spawn "okular")
    , ("M-d", spawn "dolphin")
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
    , ((mod4Mask, xK_p), spawn "kquitapp5 plasmashell ; /usr/bin/plasmashell --shut-up")
    ]

kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
    override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
    return $ maybe False (elem $ fromIntegral override) wt
