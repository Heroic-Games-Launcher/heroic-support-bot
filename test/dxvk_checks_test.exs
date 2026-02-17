defmodule DXVKChecksTest do
  use ExUnit.Case

  test "detects outdated GPU driver for DXVK" do
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

    assert Enum.member?(issues, "DXVKRequiresNewerDriver")
  end
end
