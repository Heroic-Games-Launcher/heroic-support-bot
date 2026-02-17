defmodule MacChecksTest do
  use ExUnit.Case

  test "detects missing Rosetta on MacOS" do
    content = """
    (14:13:39) [INFO]:    Launching "Bendy and the Ink Machine" (legendary)
    (14:13:39) [INFO]:    Native? false
    (14:13:39) [INFO]:    Installed in: /Users/user/Games/Heroic/BendyandtheInkMachine

    (14:13:39) [INFO]:    System Info:
    CPU: 10x Apple M4
    Memory: 17.18 GB (used: 7.3 GB)
    GPUs:

    OS: macOS 26.3.0 (darwin)

    The current system is not a Steam Deck

    Software Versions:
      Heroic: 2.19.1 Punk 01 - Shaka
      Legendary: 0.20.39 This Vortal Coil (Heroic)
      gogdl: 1.2.0
      comet: comet 0.2.0
      Nile: 1.1.2 Will A. Zeppeli

    (14:13:39) [INFO]:    Game Settings: {
      "autoInstallDxvk": true,
      "enableEsync": true,
      "enableMsync": true,
      "enviromentOptions": [],
      "wrapperOptions": [],
      "showFps": true,
      "language": "",
      "beforeLaunchScriptPath": "",
      "afterLaunchScriptPath": "",
      "verboseLogs": true,
      "wineVersion": {
        "wineserver": "/Users/user/Library/Application Support/heroic/tools/wine/Wine-crossover-wine-23.7.1-1/Contents/Resources/wine/bin/wineserver",
        "lib": "/Users/user/Library/Application Support/heroic/tools/wine/Wine-crossover-wine-23.7.1-1/Contents/Resources/wine/lib",
        "lib32": "/Users/user/Library/Application Support/heroic/tools/wine/Wine-crossover-wine-23.7.1-1/Contents/Resources/wine/lib",
        "bin": "/Users/user/Library/Application Support/heroic/tools/wine/Wine-crossover-wine-23.7.1-1/Contents/Resources/wine/bin/wine64",
        "name": "Wine Crossover - 23.7.1-1",
        "type": "wine"
      },
      "winePrefix": "/Users/user/Games/Heroic/Prefixes/default/Bendy and the Ink Machine"
    }

    (14:13:39) [ERROR]:   An exception occurred when launching the game:
    (14:13:39) [ERROR]:   Error: spawn Unknown system error -86
        at ChildProcess.spawn (node:internal/child_process:420:11)
        at Object.spawn (node:child_process:801:9)
        at /Applications/Heroic.app/Contents/Resources/app.asar/build/main/main.js:147:2494
        at new Promise (<anonymous>)
        at ue (/Applications/Heroic.app/Contents/Resources/app.asar/build/main/main.js:147:2393)
        at ue (/Applications/Heroic.app/Contents/Resources/app.asar/build/main/main.js:147:2071)
        at Qt (/Applications/Heroic.app/Contents/Resources/app.asar/build/main/main.js:153:1009)
        at Module.tf [as launch] (/Applications/Heroic.app/Contents/Resources/app.asar/build/main/main.js:100:7152)
        at Sl (/Applications/Heroic.app/Contents/Resources/app.asar/build/main/main.js:131:1529)
        at Session.<anonymous> (node:electron/js2c/browser_init:2:107280)
    ============= End of log =============
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("darwin", content)

    assert Enum.member?(issues, "missingRosetta")
  end

  test "detects when GPTK is used on an Intel mac" do
    content = """
    (21:36:25) [WARNING]: Wine version Game-Porting-Toolkit-3.0-beta5 is not valid, trying another one.
    (21:36:30) [INFO]:    Launching "Rocket League®" (legendary)
    (21:36:30) [INFO]:    Native? false
    (21:36:30) [INFO]:    Installed in: /Users/user/Games/Heroic/rocketleague

    (21:36:30) [INFO]:    System Info:
    CPU: 8x Intel(R) Core(TM) i7-4771 CPU @ 3.50GHz
    Memory: 25.77 GB (used: 8.51 GB)
    GPUs:

    OS:  15.7.1 (darwin)

    The current system is not a Steam Deck
    We are not running inside a Flatpak container

    Software Versions:
      Heroic: 2.18.1 "Waterfall Beard" Jorul
      Legendary: 0.20.37 Exit 17 (Heroic)
      gogdl: 1.1.2
      comet: comet 0.2.0
      Nile: 1.1.2 Will A. Zeppeli

    (21:36:30) [INFO]:    Game Settings: {
      "preferSystemLibs": false,
      "enableEsync": true,
      "enableMsync": false,
      "offlineMode": false,
      "enviromentOptions": [],
      "wrapperOptions": [],
      "showFps": false,
      "targetExe": "",
      "language": "",
      "beforeLaunchScriptPath": "",
      "afterLaunchScriptPath": "",
      "verboseLogs": true,
      "advertiseAvxForRosetta": false,
      "wineVersion": {
        "wineserver": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-3.0-beta5/Contents/Resources/wine/bin/wineserver",
        "lib": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-3.0-beta5/Contents/Resources/wine/lib",
        "lib32": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-3.0-beta5/Contents/Resources/wine/lib",
        "bin": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-3.0-beta5/Contents/Resources/wine/bin/wine64",
        "name": "Game-Porting-Toolkit-3.0-beta5",
        "type": "toolkit"
      },
      "winePrefix": "/Users/user/Games/Heroic/Prefixes/default/Rocket League"
    }

    ============= End of log =============
    (21:36:30) [ERROR]:   Launch aborted:
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("darwin", content)

    assert Enum.member?(issues, "gptkIncompatibleWithIntel")
  end
end
