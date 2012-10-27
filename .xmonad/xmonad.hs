import System.IO

import XMonad
import XMonad.Config.Kde
import XMonad.Layout.NoBorders
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Util.WindowProperties (getProp32s)

main = do
  xmonad kde4Config {
    startupHook = setWMName "LG3D"
  , workspaces = ["1:dev", "2:mail", "3:misc", "4:music"]
  , manageHook = ((className =? "krunner") >>= return . not --> manageHook kde4Config)
      <+> (kdeOverride --> doFloat)
      <+> (composeOne [ isFullscreen -?> doFullFloat])
      <+> (composeAll . concat $ [
        [className   =? c --> doShift "2:mail" | c <- ["Thunderbird"]]
      , [className   =? c --> doShift "4:music" | c <- ["Amarok"]]
      , [className   =? c --> doShift "1:dev" | c <- ["Firefox"]]
      ])
  , layoutHook = smartBorders (layoutHook kde4Config) 
}

kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
    override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
    return $ maybe False (elem $ fromIntegral override) wt
