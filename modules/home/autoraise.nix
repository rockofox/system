{ config, pkgs, lib, ... }: {
  home.file.autoraise = {
    executable = true;
    target = ".config/AutoRaise/config";
    text = ''
      pollMillis=50
      delay=1
      focusDelay=0
      warpX=0.5
      warpY=0.1
      scale=2.5
      altTaskSwitcher=false
      ignoreSpaceChanged=false
      ignoreApps=""
      mouseDelta=0.1
    '';
  };
}
