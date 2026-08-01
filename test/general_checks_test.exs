defmodule GeneralChecksTest do
  use ExUnit.Case

  test "detects outdated Heroic" do
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


    ============= End of log =============
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.general_checks([[], content])

    assert Enum.member?(issues, [
             "outdatedHeroicVersion",
             HeroicSupport.GameLogAnalyzer.latest_heroic()
           ])
  end

  test "ignores up-to-date Heroic" do
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
      Heroic: #{Enum.join(HeroicSupport.GameLogAnalyzer.latest_heroic(), ".")} "Waterfall Beard" Jorul
      Legendary: 0.20.37 Exit 17 (Heroic)
      gogdl: 1.1.2
      comet: comet 0.2.0
      Nile: 1.1.2 Will A. Zeppeli
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("darwin", content)

    refute Enum.member?(issues, [
             "outdatedHeroicVersion",
             HeroicSupport.GameLogAnalyzer.latest_heroic()
           ])
  end

  test "detects missing metadata message" do
    content = """
      (23:39:43) [INFO]:    Launching "Rocket League®" (legendary)
      (23:39:43) [INFO]:    Native? false
      (23:39:43) [INFO]:    Installed in: /home/user/Games/Heroic/rocketleague

      (23:39:43) [INFO]:    System Info:
      CPU: 12x 13th Gen Intel(R) Core(TM) i5-1335U
      Memory: 8.05 GB (used: 1.8 GB)
      GPUs:
        GPU 0:
          Name: Intel Corporation Raptor Lake-P [UHD Graphics]
          IDs: D=a721 V=8086 SD=2782 SV=0100
          Driver: i915
      OS: Debian GNU/Linux 13 (trixie) (linux)

      The current system is not a Steam Deck
      We are running inside a Flatpak container
      We are not running from an AppImage

      Software Versions:
        Heroic: 2.22.0 Hajrudin
        Legendary: 0.20.43 Riding Shotgun (Heroic)
        gogdl: 1.2.1
        comet: comet 0.2.0
        Nile: 1.1.2 Will A. Zeppeli

      (23:39:43) [INFO]:    Game Settings: {
        "autoInstallDxvkNvapi": true,
        "preferSystemLibs": false,
        "enableEsync": true,
        "enableFsync": true,
        "enableWineWayland": false,
        "enableHDR": false,
        "enableWoW64": false,
        "nvidiaPrime": false,
        "enviromentOptions": [],
        "wrapperOptions": [],
        "showFps": false,
        "useGameMode": true,
        "battlEyeRuntime": true,
        "eacRuntime": true,
        "language": "",
        "beforeLaunchScriptPath": "",
        "afterLaunchScriptPath": "",
        "wineVersion": {
          "bin": "/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest/proton",
          "name": "GE-Proton-latest",
          "type": "proton"
        },
        "winePrefix": "/home/user/Games/Heroic/Prefixes/default/Rocket League",
        "lastUsedLaunchOption": {
          "name": "Default",
          "parameters": "",
          "type": "basic"
        }
      }
      Stored at: /home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/GamesConfig/Sugar.json

      (23:39:43) [INFO]:    Winetricks packages: vcrun2022

      (23:39:43) [INFO]:    EOS Overlay: Not enabled
      (23:39:46) [INFO]:    Launching Rocket League®: HEROIC_APP_NAME=Sugar HEROIC_APP_RUNNER=legendary GAMEID=umu-252950 HEROIC_APP_SOURCE=epic STORE=egs STEAM_COMPAT_INSTALL_PATH=/home/user/Games/Heroic/rocketleague LD_PRELOAD= STEAM_COMPAT_CLIENT_INSTALL_PATH=/home/user/.var/app/com.heroicgameslauncher.hgl/.steam/steam WINEPREFIX="/home/user/Games/Heroic/Prefixes/default/Rocket League" STEAM_COMPAT_DATA_PATH="/home/user/Games/Heroic/Prefixes/default/Rocket League" PROTONPATH=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest WINE_FULLSCREEN_FSR=0 PROTON_ENABLE_NVAPI=1 DXVK_NVAPI_ALLOW_OTHER_DRIVERS=1 PROTON_EAC_RUNTIME=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/eac_runtime PROTON_BATTLEYE_RUNTIME=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/battleye_runtime STEAM_COMPAT_APP_ID=0 SteamAppId=0 SteamGameId=heroic-rocketleague PROTON_LOG_DIR=/home/user/.var/app/com.heroicgameslauncher.hgl WINEDEBUG= fixme DXVK_LOG_LEVEL=info VKD3D_DEBUG=fixme LEGENDARY_CONFIG_PATH=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/legendaryConfig/legendary /app/bin/heroic/resources/app.asar.unpacked/build/bin/x64/linux/legendary launch Sugar --no-wine --wrapper "/app/bin/gamemoderun "/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/umu/umu_run.py"" --language en

      (23:39:46) [INFO]:    Game Output:
      [cli] INFO: Logging in...
      [Core] INFO: Trying to re-use existing login session...
      [cli] INFO: Checking for updates...
      [cli] CRITICAL: Metadata for "Sugar" does not exist, cannot launch!
      ============= End of log =============
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.general_checks([[], content])

    assert Enum.member?(issues, "missingMetadata")
  end

  test "detects common pirated games sources" do
    Enum.each(
      ["SteamRIP", "steamrip", "FitGirl", "fit girl", "repack", "steamunlocked", "mactnt"],
      fn site ->
        content = """
          (23:39:43) [INFO]:    Launching "whatever" (sideloaded)
          (23:39:43) [INFO]:    Native? false
          (23:39:43) [INFO]:    Installed in: /home/user/Games/Heroic/#{site}_game

          (23:39:43) [INFO]:    System Info:
          CPU: 12x 13th Gen Intel(R) Core(TM) i5-1335U
          Memory: 8.05 GB (used: 1.8 GB)
          GPUs:
            GPU 0:
              Name: Intel Corporation Raptor Lake-P [UHD Graphics]
              IDs: D=a721 V=8086 SD=2782 SV=0100
              Driver: i915
          OS: Debian GNU/Linux 13 (trixie) (linux)

          The current system is not a Steam Deck
          We are running inside a Flatpak container
          We are not running from an AppImage

          Software Versions:
            Heroic: 2.22.0 Hajrudin
            Legendary: 0.20.43 Riding Shotgun (Heroic)
            gogdl: 1.2.1
            comet: comet 0.2.0
            Nile: 1.1.2 Will A. Zeppeli

          (23:39:43) [INFO]:    Game Settings: {
            "autoInstallDxvkNvapi": true,
            "preferSystemLibs": false,
            "enableEsync": true,
            "enableFsync": true,
            "enableWineWayland": false,
            "enableHDR": false,
            "enableWoW64": false,
            "nvidiaPrime": false,
            "enviromentOptions": [],
            "wrapperOptions": [],
            "showFps": false,
            "useGameMode": true,
            "battlEyeRuntime": true,
            "eacRuntime": true,
            "language": "",
            "beforeLaunchScriptPath": "",
            "afterLaunchScriptPath": "",
            "wineVersion": {
              "bin": "/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest/proton",
              "name": "GE-Proton-latest",
              "type": "proton"
            },
            "winePrefix": "/home/user/Games/Heroic/Prefixes/game",
            "lastUsedLaunchOption": {
              "name": "Default",
              "parameters": "",
              "type": "basic"
            }
          }
          Stored at: /home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/GamesConfig/asdasdasd.json

          (23:39:43) [INFO]:    Winetricks packages: vcrun2022
          (23:39:46) [INFO]:    Launching ....
        """

        [issues, _] = HeroicSupport.GameLogAnalyzer.general_checks([[], content])

        assert Enum.member?(issues, "piratedGameDetected")
      end
    )
  end

  test "checks for pirated game only if sideloaded" do
    platforms = ["legendary", "gog", "zoom", "amazon"]

    Enum.each(
      ["SteamRIP", "steamrip", "FitGirl", "fit girl", "repack", "steamunlocked", "mactnt"],
      fn site ->
        content = """
          (23:39:43) [INFO]:    Launching "whatever" (#{Enum.random(platforms)})
          (23:39:43) [INFO]:    Native? false
          (23:39:43) [INFO]:    Installed in: /home/user/Games/Heroic/#{site}_game

          (23:39:43) [INFO]:    System Info:
          CPU: 12x 13th Gen Intel(R) Core(TM) i5-1335U
          Memory: 8.05 GB (used: 1.8 GB)
          GPUs:
            GPU 0:
              Name: Intel Corporation Raptor Lake-P [UHD Graphics]
              IDs: D=a721 V=8086 SD=2782 SV=0100
              Driver: i915
          OS: Debian GNU/Linux 13 (trixie) (linux)

          The current system is not a Steam Deck
          We are running inside a Flatpak container
          We are not running from an AppImage

          Software Versions:
            Heroic: 2.22.0 Hajrudin
            Legendary: 0.20.43 Riding Shotgun (Heroic)
            gogdl: 1.2.1
            comet: comet 0.2.0
            Nile: 1.1.2 Will A. Zeppeli

          (23:39:43) [INFO]:    Game Settings: {
            "autoInstallDxvkNvapi": true,
            "preferSystemLibs": false,
            "enableEsync": true,
            "enableFsync": true,
            "enableWineWayland": false,
            "enableHDR": false,
            "enableWoW64": false,
            "nvidiaPrime": false,
            "enviromentOptions": [],
            "wrapperOptions": [],
            "showFps": false,
            "useGameMode": true,
            "battlEyeRuntime": true,
            "eacRuntime": true,
            "language": "",
            "beforeLaunchScriptPath": "",
            "afterLaunchScriptPath": "",
            "wineVersion": {
              "bin": "/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest/proton",
              "name": "GE-Proton-latest",
              "type": "proton"
            },
            "winePrefix": "/home/user/Games/Heroic/Prefixes/game",
            "lastUsedLaunchOption": {
              "name": "Default",
              "parameters": "",
              "type": "basic"
            }
          }
          Stored at: /home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/GamesConfig/asdasdasd.json

          (23:39:43) [INFO]:    Winetricks packages: vcrun2022
          (23:39:46) [INFO]:    Launching ....
        """

        [issues, _] = HeroicSupport.GameLogAnalyzer.general_checks([[], content])

        refute Enum.member?(issues, "piratedGameDetected")
      end
    )
  end

  test "don't flag as pirated if 'wine repack'" do
    content = """
      (23:39:43) [INFO]:    Launching "whatever" (sideloaded)
      (23:39:43) [INFO]:    Native? false
      (23:39:43) [INFO]:    Installed in: /home/user/Games/Heroic/normal game _game

      (23:39:43) [INFO]:    System Info:
      CPU: 12x 13th Gen Intel(R) Core(TM) i5-1335U
      Memory: 8.05 GB (used: 1.8 GB)
      GPUs:
        GPU 0:
          Name: Intel Corporation Raptor Lake-P [UHD Graphics]
          IDs: D=a721 V=8086 SD=2782 SV=0100
          Driver: i915
      OS: Debian GNU/Linux 13 (trixie) (linux)

      The current system is not a Steam Deck
      We are running inside a Flatpak container
      We are not running from an AppImage

      Software Versions:
        Heroic: 2.22.0 Hajrudin
        Legendary: 0.20.43 Riding Shotgun (Heroic)
        gogdl: 1.2.1
        comet: comet 0.2.0
        Nile: 1.1.2 Will A. Zeppeli

      (23:39:43) [INFO]:    Game Settings: {
        "autoInstallDxvkNvapi": true,
        "preferSystemLibs": false,
        "enableEsync": true,
        "enableFsync": true,
        "enableWineWayland": false,
        "enableHDR": false,
        "enableWoW64": false,
        "nvidiaPrime": false,
        "enviromentOptions": [],
        "wrapperOptions": [],
        "showFps": false,
        "useGameMode": true,
        "battlEyeRuntime": true,
        "eacRuntime": true,
        "language": "",
        "beforeLaunchScriptPath": "",
        "afterLaunchScriptPath": "",
        "wineVersion": {
          "bin": "/usr/bin/wine",
          "name": "wine-9.0 (Ubuntu 9.0~repack-4build3)",
          "type": "wine",
          "wineserver": "/usr/bin/wineserver"
        },
        "winePrefix": "/home/user/Games/Heroic/Prefixes/game",
        "lastUsedLaunchOption": {
          "name": "Default",
          "parameters": "",
          "type": "basic"
        }
      }
      Stored at: /home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/GamesConfig/asdasdasd.json

      (23:39:43) [INFO]:    Winetricks packages: vcrun2022
      (23:39:46) [INFO]:    Launching ....
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.general_checks([[], content])

    refute Enum.member?(issues, "piratedGameDetected")
  end
end
