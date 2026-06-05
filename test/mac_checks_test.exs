defmodule MacChecksTest do
  alias HeroicSupport.GameLogAnalyzer
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

  test "detects not sonoma or higher" do
    ["12.7.6", "13.7.8"]
    |> Enum.each(fn ver ->
      content = """
      (21:36:30) [INFO]:    Launching "Rocket League®" (legendary)
      (21:36:30) [INFO]:    Native? false
      (21:36:30) [INFO]:    Installed in: /Users/user/Games/Heroic/rocketleague

      (21:36:30) [INFO]:    System Info:
      CPU: 8x Intel(R) Core(TM) i7-4771 CPU @ 3.50GHz
      Memory: 25.77 GB (used: 8.51 GB)
      GPUs:

      OS: #{ver} (darwin)

      The current system is not a Steam Deck
      We are not running inside a Flatpak container

      Software Versions:
        Heroic: 2.18.1 "Waterfall Beard" Jorul
        Legendary: 0.20.37 Exit 17 (Heroic)
        gogdl: 1.1.2
        comet: comet 0.2.0
        Nile: 1.1.2 Will A. Zeppeli
      """

      [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("darwin", content)

      assert Enum.member?(issues, "sonomaOrHigherRequired")
    end)
  end

  test "detects outdated OS version" do
    [
      ["14.5.1", GameLogAnalyzer.latest_sonoma()],
      ["15.1.4", GameLogAnalyzer.latest_sequoia()],
      ["MacOS 26.0", GameLogAnalyzer.latest_tahoe()]
    ]
    |> Enum.each(fn [ver, latest] ->
      content = """
      (21:36:30) [INFO]:    Launching "Rocket League®" (legendary)
      (21:36:30) [INFO]:    Native? false
      (21:36:30) [INFO]:    Installed in: /Users/user/Games/Heroic/rocketleague

      (21:36:30) [INFO]:    System Info:
      CPU: 8x Intel(R) Core(TM) i7-4771 CPU @ 3.50GHz
      Memory: 25.77 GB (used: 8.51 GB)
      GPUs:

      OS: #{ver} (darwin)

      The current system is not a Steam Deck
      We are not running inside a Flatpak container

      Software Versions:
        Heroic: 2.18.1 "Waterfall Beard" Jorul
        Legendary: 0.20.37 Exit 17 (Heroic)
        gogdl: 1.1.2
        comet: comet 0.2.0
        Nile: 1.1.2 Will A. Zeppeli
      """

      [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("darwin", content)

      assert Enum.member?(issues, ["outdatedMacOsVersion", latest])
    end)
  end

  test "does not flag up-to-date macos versions" do
    [
      [GameLogAnalyzer.latest_sonoma() |> Enum.join("."), GameLogAnalyzer.latest_sonoma()],
      [GameLogAnalyzer.latest_sequoia() |> Enum.join("."), GameLogAnalyzer.latest_sequoia()],
      [GameLogAnalyzer.latest_tahoe() |> Enum.join("."), GameLogAnalyzer.latest_tahoe()]
    ]
    |> Enum.each(fn [ver, latest] ->
      content = """
      (21:36:30) [INFO]:    Launching "Rocket League®" (legendary)
      (21:36:30) [INFO]:    Native? false
      (21:36:30) [INFO]:    Installed in: /Users/user/Games/Heroic/rocketleague

      (21:36:30) [INFO]:    System Info:
      CPU: 8x Intel(R) Core(TM) i7-4771 CPU @ 3.50GHz
      Memory: 25.77 GB (used: 8.51 GB)
      GPUs:

      OS: #{ver} (darwin)

      The current system is not a Steam Deck
      We are not running inside a Flatpak container

      Software Versions:
        Heroic: 2.18.1 "Waterfall Beard" Jorul
        Legendary: 0.20.37 Exit 17 (Heroic)
        gogdl: 1.1.2
        comet: comet 0.2.0
        Nile: 1.1.2 Will A. Zeppeli
      """

      [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("darwin", content)

      refute Enum.member?(issues, ["outdatedMacOsVersion" | latest])
    end)
  end

  test "detects ubisoft game not using Crossover" do
    content = """
      (12:59:26) [INFO]:    Launching "Brawlhalla" (legendary)
      (12:59:26) [INFO]:    Native? false
      (12:59:26) [INFO]:    Installed in: /Users/user/Games/Heroic/Prefixes/Brawlhalla
      (12:59:26) [INFO]:    Managed by a third-party app: UbisoftConnect

      (12:59:26) [INFO]:    System Info:
      CPU: 10x Apple M4
      Memory: 17.18 GB (used: 6.78 GB)
      GPUs:

      OS: macOS 15.6.1 (darwin)

      The current system is not a Steam Deck

      Software Versions:
        Heroic: 2.22.0 Hajrudin
        Legendary: 0.20.43 Riding Shotgun (Heroic)
        gogdl: 1.2.1
        comet: comet 0.2.0
        Nile: 1.1.2 Will A. Zeppeli

      (12:59:26) [INFO]:    Game Settings: {
        "enableEsync": true,
        "enableMsync": true,
        "offlineMode": false,
        "enviromentOptions": [],
        "wrapperOptions": [],
        "showFps": false,
        "targetExe": "",
        "language": "",
        "beforeLaunchScriptPath": "",
        "afterLaunchScriptPath": "",
        "advertiseAvxForRosetta": false,
        "wineVersion": {
          "wineserver": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-latest/Contents/Resources/wine/bin/wineserver",
          "lib": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-latest/Contents/Resources/wine/lib",
          "lib32": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-latest/Contents/Resources/wine/lib",
          "bin": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-latest/Contents/Resources/wine/bin/wine64",
          "name": "Game-Porting-Toolkit-latest",
          "type": "toolkit"
        },
        "winePrefix": "/Users/user/Games/Heroic/Prefixes/Brawlhalla"
      }
      Stored at: /Users/user/Library/Application Support/heroic/GamesConfig/c051e0b1433d4308baa920c08ba1a8eb.json

      (12:59:26) [INFO]:    ...
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("darwin", content)

    assert Enum.member?(issues, "ubisoftRequiresCrossover")
  end

  test "detects ea game not using Crossover" do
    content = """
      (18:17:55) [INFO]:    Launching "STAR WARS™ Battlefront™ II: Celebration Edition" (legendary)
      (18:17:55) [INFO]:    Native? false
      (18:17:55) [INFO]:    Installed in: /Users/user/Games/Heroic/Prefixes/STAR WARS Battlefront II Celebration Edition
      (18:17:55) [INFO]:    Managed by a third-party app: Origin

      (18:17:55) [INFO]:    System Info:
      CPU: 8x Apple M2
      Memory: 8.59 GB (used: 3.06 GB)
      GPUs:

      OS: macOS 26.5.1 (darwin)

      The current system is not a Steam Deck

      Software Versions:
        Heroic: 2.22.0 Hajrudin
        Legendary: 0.20.43 Riding Shotgun (Heroic)
        gogdl: 1.2.1
        comet: comet 0.2.0
        Nile: 1.1.2 Will A. Zeppeli

      (18:17:55) [INFO]:    Game Settings: {
        "enableEsync": true,
        "enableMsync": true,
        "enviromentOptions": [],
        "wrapperOptions": [],
        "showFps": false,
        "language": "",
        "beforeLaunchScriptPath": "",
        "afterLaunchScriptPath": "",
        "advertiseAvxForRosetta": false,
        "wineVersion": {
          "wineserver": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-latest/Contents/Resources/wine/bin/wineserver",
          "lib": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-latest/Contents/Resources/wine/lib",
          "lib32": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-latest/Contents/Resources/wine/lib",
          "bin": "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-latest/Contents/Resources/wine/bin/wine64",
          "name": "Game-Porting-Toolkit-latest",
          "type": "toolkit"
        },
        "winePrefix": "/Users/user/Games/Heroic/Prefixes/STAR WARS Battlefront II Celebration Edition"
      }
      Stored at: /Users/user/Library/Application Support/heroic/GamesConfig/MtMassive.json

      (18:17:55) [INFO]:    Anticheat Status: Unknown
      (18:17:55) [INFO]:    Anticheats: FairFight

      (18:17:55) [INFO]:    Winetricks packages:

      (18:18:01) [INFO]:    Launching STAR WARS™ Battlefront™ II: Celebration Edition: HEROIC_APP_NAME=MtMassive HEROIC_APP_RUNNER=legendary GAMEID=umu-0 HEROIC_APP_SOURCE=epic STORE=egs LD_PRELOAD= WINEPREFIX="/Users/user/Games/Heroic/Prefixes/STAR WARS Battlefront II Celebration Edition" WINE_FULLSCREEN_FSR=0 WINEESYNC=1 WINEMSYNC=1 LEGENDARY_CONFIG_PATH="/Users/user/Library/Application Support/heroic/legendaryConfig/legendary" /Applications/Heroic.app/Contents/Resources/app.asar.unpacked/build/bin/arm64/darwin/legendary launch MtMassive --wine "/Users/user/Library/Application Support/heroic/tools/game-porting-toolkit/Game-Porting-Toolkit-latest/Contents/Resources/wine/bin/wine64" --language en --origin

      (18:18:01) [INFO]:    Game Output:
      [cli] INFO: Logging in...
      [Core] INFO: Trying to re-use existing login session...
      esync: up and running.
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      00b4:fixme:exec:SHELL_execute flags ignored: 0x00000100
      Application could not be started, or no application associated with the specified file.
      ShellExecuteEx failed
      :
      Invalid name.
      ============= End of log =============
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("darwin", content)

    assert Enum.member?(issues, "eaRequiresCrossover")
  end
end
