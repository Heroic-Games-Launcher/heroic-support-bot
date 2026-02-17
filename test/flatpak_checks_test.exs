defmodule FlatpakChecksTest do
  use ExUnit.Case

  test "detects if user needs to run `flatpak update`: nvidia gpu, flatpak, but only llvmpipe device" do
    content = """
    (14:48:58) [INFO]:    Launching "Europa Universalis IV" (legendary)
    (14:48:58) [INFO]:    Native? false
    (14:48:58) [INFO]:    Installed in: /mnt/Mint/Games/EuropaUniversalis4

    (14:48:58) [INFO]:    System Info:
    CPU: 6x Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz
    Memory: 8.26 GB (used: 2.13 GB)
    GPUs:
      GPU 0:
        Name: NVIDIA Corporation GP107 [GeForce GTX 1050 Ti]
        IDs: D=1c82 V=10de SD=1c82 SV=10de
        Driver: nvidia
    OS: Linux Mint 22.2 (Zara) (linux)

    The current system is not a Steam Deck
    We are running inside a Flatpak container

    Software Versions:
      Heroic: 2.18.1 "Waterfall Beard" Jorul
      Legendary: 0.20.37 Exit 17 (Heroic)
      gogdl: 1.1.2
      comet: comet 0.2.0
      Nile: 1.1.2 Will A. Zeppeli

    (14:48:58) [INFO]:    Game Settings: {
      "autoInstallDxvkNvapi": true,
      "preferSystemLibs": false,
      "enableEsync": false,
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
      "verboseLogs": true,
      "wineVersion": {
        "bin": "/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest/proton",
        "name": "Proton - GE-Proton-latest",
        "type": "proton"
      },
      "winePrefix": "/home/user/Games/Heroic/Prefixes/default",
      "disableUMU": false
    }

    (14:48:59) [INFO]:    Winetricks packages: d3dx9_43, d3dcompiler_43, vcrun2022

    (14:49:04) [INFO]:    Launching Europa Universalis IV: HEROIC_APP_NAME=da0103e959e54d139d0c109ded3b3672 HEROIC_APP_RUNNER=legendary GAMEID=umu-0 HEROIC_APP_SOURCE=epic STORE=egs STEAM_COMPAT_INSTALL_PATH=/mnt/Mint/Games/EuropaUniversalis4 LD_PRELOAD= STEAM_COMPAT_CLIENT_INSTALL_PATH=/home/user/.var/app/com.heroicgameslauncher.hgl/.steam/steam WINEPREFIX=/home/user/Games/Heroic/Prefixes/default STEAM_COMPAT_DATA_PATH=/home/user/Games/Heroic/Prefixes/default PROTONPATH=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest WINE_FULLSCREEN_FSR=0 PROTON_NO_ESYNC=1 PROTON_ENABLE_NVAPI=1 DXVK_NVAPI_ALLOW_OTHER_DRIVERS=1 PROTON_EAC_RUNTIME=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/eac_runtime PROTON_BATTLEYE_RUNTIME=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/battleye_runtime STEAM_COMPAT_APP_ID=0 SteamAppId=0 SteamGameId=heroic-EuropaUniversalis4 PROTON_LOG_DIR=/home/user/.var/app/com.heroicgameslauncher.hgl WINEDEBUG=+fixme DXVK_LOG_LEVEL=info VKD3D_DEBUG=fixme LEGENDARY_CONFIG_PATH=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/legendaryConfig/legendary /app/bin/heroic/resources/app.asar.unpacked/build/bin/x64/linux/legendary launch da0103e959e54d139d0c109ded3b3672 --no-wine --wrapper "/app/bin/gamemoderun "/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/umu/umu_run.py"" --language en

    (14:49:04) [INFO]:    Game Output:
    [cli] INFO: Logging in...
    [Core] INFO: Trying to re-use existing login session...
    [cli] INFO: Checking for updates...
    [Core] INFO: Getting authentication token...
    [cli] INFO: Launching da0103e959e54d139d0c109ded3b3672...
    gamemodeauto:
    gamemodeauto:
    INFO: umu-launcher version 1.2.9 (3.11.13 (main, Nov 10 2011, 15:00:00) [GCC 13.2.0])
    INFO: steamrt3 is up to date
    ProtonFixes[449] WARN: [CONFIG]: Parent directory "/home/user/.config/protonfixes" does not exist. Abort.
    ProtonFixes[449] INFO: Running protonfixes on "GE-Proton10-15", build at 2025-08-27 20:08:46+00:00.
    ProtonFixes[449] INFO: Running checks
    ProtonFixes[449] INFO: All checks successful
    ProtonFixes[449] WARN: Game title not found in CSV
    ProtonFixes[449] INFO: Non-steam game UNKNOWN (umu-0)
    ProtonFixes[449] INFO: EGS store specified, using EGS database
    ProtonFixes[449] INFO: Using global defaults for UNKNOWN (umu-0)
    ProtonFixes[449] INFO: Checking if winetricks "vcrun2022" is installed
    ProtonFixes[449] INFO: Adding key: HKCR\com.epicgames.launcher
    fsync: up and running.
    002c:fixme:winediag:loader_init wine-staging 10.0 is a testing version containing experimental patches.
    002c:fixme:winediag:loader_init Please mention your exact version when filing bug reports on winehq.org.
    ProtonFixes[449] INFO: Non-steam game UNKNOWN (umu-0)
    ProtonFixes[449] INFO: EGS store specified, using EGS database
    ProtonFixes[449] INFO: No global protonfix found for UNKNOWN (umu-0)
    Proton: /mnt/Mint/Games/EuropaUniversalis4/dowser.exe
    Proton: Executable a unix path, launching with /unix option.
    fsync: up and running.
    info:  Found device: llvmpipe (LLVM 17.0.6, 256 bits) (llvmpipe 0.0.1)
    0214:err:openxr:get_vulkan_extensions Could not create key, status 0x2.
    warn:  OpenXR: Unable to get required Vulkan Device extensions size
    warn:  DXGI: Found monitors not associated with any adapter, using fallback
    info:  Adapter LUID 0: 0:408

    02d0:fixme:dxcore:DXCoreCreateAdapterFactory riid {78ee5945-c36e-4b13-a669-005dd11c0f06}, ppv 000000000081E6C8 stub!
    info:  Game: Paradox Launcher.exe
    info:  DXVK: v2.7-46-gbcb0abde99af4c8
    info:  Build: x86_64 gcc 10.3.0
    info:  Vulkan: Found vkGetInstanceProcAddr in winevulkan.dll @ 0x6ffffc88e430
    info:  Extension providers:
    info:    Platform WSI
    info:    OpenVR
    info:  OpenVR: could not open registry key, status 2
    info:  OpenVR: Failed to locate module
    info:    OpenXR
    02d0:err:openxr:get_vulkan_extensions Could not create key, status 0x2.
    warn:  OpenXR: Unable to get required Vulkan instance extensions size
    info:  Enabled instance extensions:
    info:    VK_EXT_surface_maintenance1
    info:    VK_KHR_get_surface_capabilities2
    info:    VK_KHR_surface
    info:    VK_KHR_win32_surface
    info:  Found device: llvmpipe (LLVM 17.0.6, 256 bits) (llvmpipe 0.0.1)
    02d0:err:openxr:get_vulkan_extensions Could not create key, status 0x2.
    warn:  OpenXR: Unable to get required Vulkan Device extensions size
    warn:  DXGI: Found monitors not associated with any adapter, using fallback
    info:  Adapter LUID 0: 0:40f

    ============= End of log =============
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("linux", content)

    assert Enum.member?(issues, "flatpakNvidiaOutdated")
  end

  test "does not flag missing `flatpak update` if nvidia device found or using only amd" do
    content = """
    (17:33:32) [INFO]:    Launching "Fall Guys" (legendary)
    (17:33:32) [INFO]:    Native? false
    (17:33:32) [INFO]:    Installed in: /home/deck/Games/Heroic/FallGuys

    (17:33:32) [INFO]:    System Info:
    CPU: 8x AMD Custom APU 0932
    Memory: 15.53 GB (used: 3.7 GB)
    GPUs:
      GPU 0:
        Name: Advanced Micro Devices, Inc. [AMD/ATI] Sephiroth [AMD Custom GPU 0405]
        IDs: D=1435 V=1002 SD=0123 SV=1002
        Driver: amdgpu
    OS: SteamOS 3.7.15 holo (linux)

    The current system is a Steam Deck (model: OLED) in game mode
    We are running inside a Flatpak container

    Software Versions:
      Heroic: 2.18.1 "Waterfall Beard" Jorul
      Legendary: 0.20.37 Exit 17 (Heroic)
      gogdl: 1.1.2
      comet: comet 0.2.0
      Nile: 1.1.2 Will A. Zeppeli

    (17:33:32) [INFO]:    Game Settings: {
      "preferSystemLibs": false,
      "enableEsync": true,
      "enableFsync": true,
      "enableWineWayland": false,
      "enableHDR": false,
      "enableWoW64": false,
      "nvidiaPrime": false,
      "enviromentOptions": [
        {
          "key": "UMU_LOG",
          "value": "1"
        }
      ],
      "wrapperOptions": [],
      "showFps": false,
      "useGameMode": true,
      "battlEyeRuntime": true,
      "eacRuntime": true,
      "language": "",
      "beforeLaunchScriptPath": "",
      "afterLaunchScriptPath": "",
      "verboseLogs": true,
      "wineVersion": {
        "bin": "/home/deck/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton10-6/proton",
        "name": "Proton - GE-Proton10-6",
        "type": "proton"
      },
      "winePrefix": "/home/deck/Games/Heroic/Prefixes/default/Fall Guys"
    }

    (17:33:32) [INFO]:    Anticheats: Easy Anti-Cheat

    (17:33:32) [INFO]:    Anticheat Status: Running
    (17:33:33) [INFO]:    Winetricks packages: vcrun2022

    (17:33:38) [INFO]:    Launching Fall Guys: HEROIC_APP_NAME=0a2d9f6403244d12969e11da6713137b HEROIC_APP_RUNNER=legendary GAMEID=umu-0 HEROIC_APP_SOURCE=epic STORE=egs STEAM_COMPAT_INSTALL_PATH=/home/deck/Games/Heroic/FallGuys UMU_LOG=1 LD_PRELOAD= STEAM_COMPAT_CLIENT_INSTALL_PATH=/home/deck/.var/app/com.heroicgameslauncher.hgl/.steam/steam WINEPREFIX="/home/deck/Games/Heroic/Prefixes/default/Fall Guys" STEAM_COMPAT_DATA_PATH="/home/deck/Games/Heroic/Prefixes/default/Fall Guys" PROTONPATH=/home/deck/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton10-6 WINE_FULLSCREEN_FSR=0 PROTON_ENABLE_NVAPI=1 DXVK_NVAPI_ALLOW_OTHER_DRIVERS=1 PROTON_EAC_RUNTIME=/home/deck/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/eac_runtime PROTON_BATTLEYE_RUNTIME=/home/deck/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/battleye_runtime STEAM_COMPAT_APP_ID=0 PROTON_LOG_DIR=/home/deck/.var/app/com.heroicgameslauncher.hgl WINEDEBUG=+fixme DXVK_LOG_LEVEL=info VKD3D_DEBUG=fixme LEGENDARY_CONFIG_PATH=/home/deck/.var/app/com.heroicgameslauncher.hgl/config/heroic/legendaryConfig/legendary /app/bin/heroic/resources/app.asar.unpacked/build/bin/x64/linux/legendary launch 0a2d9f6403244d12969e11da6713137b --no-wine --wrapper "/app/bin/gamemoderun "/home/deck/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/umu/umu_run.py"" --language en --skip-version-check

    (17:33:38) [INFO]:    Game Output:
    [cli] INFO: Logging in...
    [Core] INFO: Trying to re-use existing login session...
    [Core] INFO: Getting authentication token...
    [cli] INFO: Launching 0a2d9f6403244d12969e11da6713137b...
    gamemodeauto:
    gamemodeauto:
    ProtonFixes[403] WARN: [CONFIG]: Parent directory "/home/deck/.config/protonfixes" does not exist. Abort.
    ProtonFixes[403] INFO: Running protonfixes on "GE-Proton10-6", build at 2025-06-29 23:54:46+00:00.
    ProtonFixes[403] INFO: Running checks
    ProtonFixes[403] INFO: All checks successful
    ProtonFixes[403] WARN: Game title not found in CSV
    ProtonFixes[403] INFO: Non-steam game UNKNOWN (umu-0)
    ProtonFixes[403] INFO: EGS store specified, using EGS database
    ProtonFixes[403] INFO: Using global defaults for UNKNOWN (umu-0)
    ProtonFixes[403] INFO: Checking if winetricks "vcrun2022" is installed
    ProtonFixes[403] INFO: Adding key: HKCR\com.epicgames.launcher
    fsync: up and running.

    info:  Game: FallGuys_client_game.exe
    info:  DXVK: v2.6.1-366-gb8db71be68f0392
    info:  Build: x86_64 gcc 10.3.0
    info:  Vulkan: Found vkGetInstanceProcAddr in winevulkan.dll @ 0x6ffffd2ae540
    info:  Extension providers:
    info:    Platform WSI
    info:    OpenVR
    info:  OpenVR: could not open registry key, status 2
    info:  OpenVR: Failed to locate module
    info:    OpenXR
    0304:err:openxr:get_vulkan_extensions Could not create key, status 0x2.
    warn:  OpenXR: Unable to get required Vulkan instance extensions size
    info:  Enabled instance extensions:
    info:    VK_EXT_surface_maintenance1
    info:    VK_KHR_get_surface_capabilities2
    info:    VK_KHR_surface
    info:    VK_KHR_win32_surface
    ATTENTION: default value of option vk_xwayland_wait_ready overridden by environment.
    ATTENTION: default value of option vk_xwayland_wait_ready overridden by environment.
    ATTENTION: default value of option vk_xwayland_wait_ready overridden by environment.
    ATTENTION: default value of option vk_xwayland_wait_ready overridden by environment.
    info:  Found device: AMD Custom GPU 0932 (RADV VANGOGH) (radv 25.2.4)
    info:  Found device: llvmpipe (LLVM 21.1.3, 256 bits) (llvmpipe 25.2.4)
    info:    Skipping: Software driver
    0304:err:openxr:get_vulkan_extensions Could not create key, status 0x2.
    warn:  OpenXR: Unable to get required Vulkan Device extensions size
    info:  Game: FallGuys_client_game.exe
    info:  DXVK: v2.6.1-366-gb8db71be68f0392
    info:  Build: x86_64 gcc 10.3.0
    info:  Vulkan: Found vkGetInstanceProcAddr in winevulkan.dll @ 0x6ffffd2ae540
    info:  Extension providers:
    info:    Platform WSI
    info:    OpenVR
    info:  OpenVR: could not open registry key, status 2
    info:  OpenVR: Failed to locate module
    info:    OpenXR
    info:  Enabled instance extensions:
    info:    VK_EXT_surface_maintenance1
    info:    VK_KHR_get_surface_capabilities2
    info:    VK_KHR_surface
    info:    VK_KHR_win32_surface
    ATTENTION: default value of option vk_xwayland_wait_ready overridden by environment.
    ATTENTION: default value of option vk_xwayland_wait_ready overridden by environment.
    ATTENTION: default value of option vk_xwayland_wait_ready overridden by environment.
    ATTENTION: default value of option vk_xwayland_wait_ready overridden by environment.
    info:  Found device: AMD Custom GPU 0932 (RADV VANGOGH) (radv 25.2.4)
    info:  Found device: llvmpipe (LLVM 21.1.3, 256 bits) (llvmpipe 25.2.4)
    info:    Skipping: Software driver
    info:  D3D11InternalCreateDevice: Maximum supported feature level: D3D_FEATURE_LEVEL_12_1
    info:  D3D11InternalCreateDevice: Using feature level D3D_FEATURE_LEVEL_11_0
    info:  Creating device:
    info:  AMD Custom GPU 0932 (RADV VANGOGH):
    info:    Driver   : radv 25.2.4
    info:  Queues:
    info:    Graphics : (0, 0)
    info:    Transfer : (1, 0)
    info:    Sparse   : (0, 0)
    info:  Memory:
    info:    Heap 0: 3.0 GiB
    info:    Budget: 2.82 GiB
    info:      Type  2: HOST_VISIBLE | HOST_COHERENT
    info:      Type  5: HOST_VISIBLE | HOST_COHERENT | HOST_CACHED
    info:      Type  6: HOST_VISIBLE | HOST_COHERENT | HOST_CACHED
    info:      Type  8: HOST_VISIBLE | HOST_COHERENT | DEVICE_COHERENT | DEVICE_UNCACHED
    info:      Type 10: HOST_VISIBLE | HOST_COHERENT | HOST_CACHED | DEVICE_COHERENT | DEVICE_UNCACHED
    info:    Heap 1: 6.0 GiB (DEVICE_LOCAL)
    info:    Budget: 5.65 GiB
    info:      Type  0: DEVICE_LOCAL
    info:      Type  1: DEVICE_LOCAL
    info:      Type  3: DEVICE_LOCAL | HOST_VISIBLE | HOST_COHERENT
    info:      Type  4: DEVICE_LOCAL | HOST_VISIBLE | HOST_COHERENT
    info:      Type  7: DEVICE_LOCAL | DEVICE_COHERENT | DEVICE_UNCACHED
    info:      Type  9: DEVICE_LOCAL | HOST_VISIBLE | HOST_COHERENT | DEVICE_COHERENT | DEVICE_UNCACHED
    info:  Found device: AMD Custom GPU 0932 (RADV VANGOGH) (radv 25.2.4)
    info:  Found device: llvmpipe (LLVM 21.1.3, 256 bits) (llvmpipe 25.2.4)
    info:    Skipping: Software driver
    info:  D3D11InternalCreateDevice: Maximum supported feature level: D3D_FEATURE_LEVEL_12_1
    info:  D3D11InternalCreateDevice: Using feature level D3D_FEATURE_LEVEL_11_1
    info:  Creating device:
    info:  AMD Custom GPU 0932 (RADV VANGOGH):
    info:    Driver   : radv 25.2.4
    info:  Queues:
    info:    Graphics : (0, 0)
    info:    Transfer : (1, 0)
    info:    Sparse   : (0, 0)
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("linux", content)

    refute Enum.member?(issues, "flatpakNvidiaOutdated")
  end

  test "does not flag missing `flatpak update` if nvidia gpu, flatpak, but both llvmpipe and nvidia devices" do
    content = """
    (23:32:53) [INFO]:    Launching "Hidden Folks" (legendary)
    (23:32:53) [INFO]:    Native? false
    (23:32:53) [INFO]:    Installed in: /home/user/Games/Heroic/HiddenFolks

    (23:32:53) [INFO]:    System Info:
    CPU: 8x Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
    Memory: 16.73 GB (used: 1.45 GB)
    GPUs:
      GPU 0:
        Name: NVIDIA Corporation GP104 [GeForce GTX 1070]
        IDs: D=1b81 V=10de SD=5173 SV=3842
        Driver: nvidia
    OS: Linux Mint 22.2 (Zara) (linux)

    The current system is not a Steam Deck
    We are running inside a Flatpak container

    Software Versions:
      Heroic: 2.18.1 "Waterfall Beard" Jorul
      Legendary: 0.20.37 Exit 17 (Heroic)
      gogdl: 1.1.2
      comet: comet 0.2.0
      Nile: 1.1.2 Will A. Zeppeli

    (23:32:53) [INFO]:    Game Settings: {
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
      "verboseLogs": true,
      "wineVersion": {
        "bin": "/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest/proton",
        "name": "Proton - GE-Proton-latest",
        "type": "proton"
      },
      "winePrefix": "/home/user/Games/Heroic/Prefixes/default/Hidden Folks"
    }

    (23:32:53) [INFO]:    Winetricks packages:

    (23:33:02) [INFO]:    Launching Hidden Folks: HEROIC_APP_NAME=886e934842de46bc8a65644e7d4fb75b HEROIC_APP_RUNNER=legendary GAMEID=umu-0 HEROIC_APP_SOURCE=epic STORE=egs STEAM_COMPAT_INSTALL_PATH=/home/user/Games/Heroic/HiddenFolks LD_PRELOAD= STEAM_COMPAT_CLIENT_INSTALL_PATH=/home/user/.var/app/com.heroicgameslauncher.hgl/.steam/steam WINEPREFIX="/home/user/Games/Heroic/Prefixes/default/Hidden Folks" STEAM_COMPAT_DATA_PATH="/home/user/Games/Heroic/Prefixes/default/Hidden Folks" PROTONPATH=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest WINE_FULLSCREEN_FSR=0 PROTON_ENABLE_NVAPI=1 DXVK_NVAPI_ALLOW_OTHER_DRIVERS=1 PROTON_EAC_RUNTIME=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/eac_runtime PROTON_BATTLEYE_RUNTIME=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/battleye_runtime STEAM_COMPAT_APP_ID=0 SteamAppId=0 SteamGameId=heroic-HiddenFolks PROTON_LOG_DIR=/home/user/.var/app/com.heroicgameslauncher.hgl WINEDEBUG=+fixme DXVK_LOG_LEVEL=info VKD3D_DEBUG=fixme LEGENDARY_CONFIG_PATH=/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/legendaryConfig/legendary /app/bin/heroic/resources/app.asar.unpacked/build/bin/x64/linux/legendary launch 886e934842de46bc8a65644e7d4fb75b --no-wine --wrapper "/app/bin/gamemoderun "/home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/runtimes/umu/umu_run.py"" --language en

    (23:33:02) [INFO]:    Game Output:
    [cli] INFO: Logging in...
    [Core] INFO: Trying to re-use existing login session...
    [cli] INFO: Checking for updates...
    [Core] INFO: Getting authentication token...
    [cli] INFO: Launching 886e934842de46bc8a65644e7d4fb75b...
    gamemodeauto:
    gamemodeauto:
    INFO: umu-launcher version 1.2.9 (3.13.8 (main, Nov 10 2011, 15:00:00) [GCC 15.2.0])
    INFO: steamrt3 is up to date
    ProtonFixes[564] INFO: Running protonfixes on "GE-Proton10-23", build at 2025-10-28 00:12:24+00:00.
    ProtonFixes[564] INFO: Running checks
    ProtonFixes[564] INFO: All checks successful
    ProtonFixes[564] WARN: Game title not found in CSV
    ProtonFixes[564] INFO: Non-steam game UNKNOWN (umu-0)
    ProtonFixes[564] INFO: EGS store specified, using EGS database
    ProtonFixes[564] INFO: Using global defaults for UNKNOWN (umu-0)
    ProtonFixes[564] INFO: Checking if winetricks "vcrun2022" is installed
    ProtonFixes[564] INFO: Installing winetricks vcrun2022
    ProtonFixes[564] INFO: Using winetricks verb "vcrun2022"
    Executing cd /home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest/protonfixes/files/bin
    ------------------------------------------------------
    winetricks latest version check update disabled
    ------------------------------------------------------
    Using winetricks 20250102-next - sha256sum: 253a809016842db5da620404581bc61eab8c90a4c430e6cf7ca5b5f9a153c6ec with wine-10.0 (Staging) and WINEARCH=win64
    Executing w_do_call vcrun2022
    Executing load_vcrun2022
    Using native,builtin override for following DLLs: concrt140 msvcp140 msvcp140_1 msvcp140_2 msvcp140_atomic_wait msvcp140_codecvt_ids vcamp140 vccorlib140 vcomp140 vcruntime140
    Executing /home/user/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton/GE-Proton-latest/files/bin/wine C:\windows\syswow64\regedit.exe /S C:\windows\Temp\_vcrun2022\override-dll.reg
    fsync: up and running.
    ...
    012c:fixme:combase:RoGetActivationFactory (L"Windows.Gaming.Input.RawGameController", {eb8d0792-e95a-4b19-afc7-0a59f8bf759e}, 00006FFFF9A78960): semi-stub
    warn:  CreateDXGIFactory2: Ignoring flags
    info:  Game: Hidden Folks.exe
    info:  DXVK: v2.7.1-200-g88fe0c686318055
    info:  Build: x86_64 gcc 10.3.0
    info:  Vulkan: Found vkGetInstanceProcAddr in winevulkan.dll @ 0x6ffff8d2e430
    info:  Extension providers:
    info:    Platform WSI
    info:    OpenVR
    info:  OpenVR: could not open registry key, status 2
    info:  OpenVR: Failed to locate module
    info:    OpenXR
    00d0:err:openxr:get_vulkan_extensions Could not create key, status 0x2.
    warn:  OpenXR: Unable to get required Vulkan instance extensions size
    info:  Enabled instance extensions:
    info:    VK_EXT_surface_maintenance1
    info:    VK_KHR_get_surface_capabilities2
    info:    VK_KHR_surface
    info:    VK_KHR_win32_surface
    info:  Found device: NVIDIA GeForce GTX 1070 (NVIDIA 535.18.2)
    info:    Skipping: Device does not support required feature 'maintenance5' (extension: VK_KHR_maintenance5)
    info:  Found device: llvmpipe (LLVM 21.1.3, 256 bits) (llvmpipe 25.2.4)
    info:    Skipping: Software driver
    warn:  DXVK: No adapters found. Please check your device filter settings
    warn:  and Vulkan drivers. A Vulkan 1.3 capable setup is required.
    err:   Failed to initialize DXVK.
    warn:  CreateDXGIFactory2: Ignoring flags
    00d0:fixme:dbghelp:elf_search_auxv can't find symbol in module
    0158:fixme:oleacc:find_class_data unhandled window class: L"msctls_progress32"
    0158:fixme:uiautomation:msaa_provider_GetPatternProvider Unimplemented patternId 10002
    0158:fixme:uiautomation:base_hwnd_provider_GetPatternProvider 0000000000844CA0, 10002, 000000000182F8A0: stub
    0158:fixme:oleacc:find_class_data unhandled window class: L"#32770"
    00d8:fixme:dbghelp:elf_search_auxv can't find symbol in module
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("linux", content)

    refute Enum.member?(issues, "flatpakNvidiaOutdated")
  end
end
