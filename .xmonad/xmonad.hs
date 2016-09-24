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
    , workspaces = ["1:dev", "2:mail", "3:misc", "4:music"]
    , manageHook = ((className =? "krunner") >>= return . not --> manageHook kde4Config)
        <+> (kdeOverride --> doFloat)
        <+> (composeOne [ isFullscreen -?> doFullFloat])
        <+> (composeAll . concat $ [
          [className   =? c --> doShift "2:mail" | c <- ["Thunderbird"]]
        , [className   =? c --> doShift "4:music" | c <- ["Amarok"]]
        , [className   =? c --> doShift "1:dev" | c <- ["Firefox"]]
        , [className   =? c --> doFloat | c <- ["pcsx"]]
        , [className   =? c --> doFloat | c <- ["mame"]]
        , [className   =? c --> doFloat | c <- ["Yabause"]]
        , [className   =? c --> doFloat | c <- ["mupen64plus"]]
        , [className   =? c --> doIgnore | c <- ["stalonetray"]]
        ])
    , layoutHook = smartBorders (layoutHook kde4Config)
    }
    `additionalKeysP`
    [ ("M-c", spawn "konsole")
    , ("M-b", spawn "firefox")
    , ("M-m", spawn "thunderbird")
    , ("M-w", spawn "twinkle")
    , ("M-x", spawn "lyx")
    , ("M-o", spawn "okular")
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
    ]

kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
    override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
    return $ maybe False (elem $ fromIntegral override) wt
