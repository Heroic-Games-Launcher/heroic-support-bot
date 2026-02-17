defmodule WineVersionsChecksTest do
  use ExUnit.Case

  test "detects usage of Wine-GE" do
    content = """
    (18:41:49) [INFO]:    Launching "Absolute Drift" (legendary)
    (18:41:49) [INFO]:    Native? false
    (18:41:49) [INFO]:    Installed in: /home/ariel/Games/Heroic/AbsoluteDrift

    (18:41:49) [INFO]:    System Info:
    CPU: 16x AMD Ryzen 7 3700X 8-Core Processor
    Memory: 33.53 GB (used: 10.29 GB)
    GPUs:
      GPU 0:
        Name: Advanced Micro Devices, Inc. [AMD/ATI] RX 5700 XT RAW II
        IDs: D=731f V=1002 SD=5701 SV=1682
        Driver: amdgpu
    OS: Linux Mint 22.2 (Zara) (linux)

    The current system is not a Steam Deck
    We are not running inside a Flatpak container
    We are not running from an AppImage

    Software Versions:
      Heroic: 2.19.1 Punk 01 - Shaka
      Legendary: 0.20.39 This Vortal Coil (Heroic)
      gogdl: 1.2.0
      comet: comet 0.2.0
      Nile:

    (18:41:49) [INFO]:    Game Settings: {
      "autoInstallDxvk": true,
      "autoInstallDxvkNvapi": false,
      "autoInstallVkd3d": true,
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
      "useGameMode": false,
      "battlEyeRuntime": true,
      "eacRuntime": true,
      "language": "",
      "beforeLaunchScriptPath": "",
      "afterLaunchScriptPath": "",
      "verboseLogs": true,
      "wineVersion": {
        "bin": "/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/bin/wine",
        "name": "Wine-GE-Proton8-25",
        "type": "wine",
        "lib": "/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/lib64",
        "lib32": "/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/lib",
        "wineserver": "/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/bin/wineserver"
      },
      "winePrefix": "/home/ariel/Games/Heroic/Prefixes/Absolute Drift"
    }

    (18:41:49) [INFO]:    Winetricks packages:

    (18:41:49) [INFO]:    EOS Overlay: Not enabled
    (18:42:02) [INFO]:    EOS Overlay: Enabling
    (18:42:03) [INFO]:    Launching Absolute Drift: HEROIC_APP_NAME=19927295d6e3467887d4e830d8c85963 HEROIC_APP_RUNNER=legendary GAMEID=umu-0 HEROIC_APP_SOURCE=epic STORE=egs STEAM_COMPAT_INSTALL_PATH=/home/ariel/Games/Heroic/AbsoluteDrift LD_PRELOAD= WINEPREFIX="/home/ariel/Games/Heroic/Prefixes/Absolute Drift" WINEDLLOVERRIDES=winemenubuilder.exe=d WINE_FULLSCREEN_FSR=0 WINEESYNC=1 WINEFSYNC=1 PROTON_EAC_RUNTIME=/home/ariel/.config/heroic/tools/runtimes/eac_runtime PROTON_BATTLEYE_RUNTIME=/home/ariel/.config/heroic/tools/runtimes/battleye_runtime ORIG_LD_LIBRARY_PATH= LD_LIBRARY_PATH=/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/lib64:/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/lib GST_PLUGIN_SYSTEM_PATH_1_0=/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/lib64/gstreamer-1.0:/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/lib/gstreamer-1.0 WINEDLLPATH=/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/lib64/wine:/home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/lib/wine SteamVirtualGamepadInfo= LEGENDARY_CONFIG_PATH=/home/ariel/.config/heroic/legendaryConfig/legendary /home/ariel/dev/oss/HeroicGamesLauncher/public/bin/x64/linux/legendary launch 19927295d6e3467887d4e830d8c85963 --wine /home/ariel/.config/heroic/tools/wine/Wine-GE-Proton8-25/bin/wine --language en

    (18:42:03) [INFO]:    Game Output:
    [cli] INFO: Logging in...
    [Core] INFO: Trying to re-use existing login session...
    [cli] INFO: Checking for updates...
    [Core] INFO: Getting authentication token...
    [cli] INFO: Launching 19927295d6e3467887d4e830d8c85963...
    fsync: up and running.
    wine: RLIMIT_NICE is <= 20, unable to use setpriority safely

    EOS Overlay update available: 1.3.3++EOSSDK+Release-Overlay-CL-45834608-Windows (Current: 1.3.1++EOSSDK+Release-Overlay-CL-41331449-Windows).
    Run "legendary eos-overlay update" to update to the latest version.
    002c:fixme:winediag:LdrInitializeThunk wine-staging 8.0 is a testing version containing experimental patches.
    002c:fixme:winediag:LdrInitializeThunk Please mention your exact version when filing bug reports on winehq.org.
    0070:fixme:hid:handle_IRP_MN_QUERY_ID Unhandled type 00000005
    0070:fixme:hid:handle_IRP_MN_QUERY_ID Unhandled type 00000005
    0070:fixme:hid:handle_IRP_MN_QUERY_ID Unhandled type 00000005
    0070:fixme:hid:handle_IRP_MN_QUERY_ID Unhandled type 00000005
    0088:err:hid:udev_bus_init UDEV monitor creation failed
    00d0:fixme:ntdll:EtwEventSetInformation (deadbeef, 2, 00000001812C4B48, 43) stub
    00d0:fixme:ntdll:EtwEventSetInformation (deadbeef, 2, 0000000140012360, 43) stub
    0114:fixme:oleacc:find_class_data unhandled window class: L"#32769"
    0114:fixme:uiautomation:uia_get_providers_for_hwnd Override provider callback currently unimplemented.
    0114:fixme:uiautomation:msaa_provider_GetPropertyValue Unimplemented propertyId 30024
    0114:fixme:uiautomation:msaa_fragment_get_FragmentRoot 0000000000B7B458, 000000000062FAC0: stub!
    0120:fixme:uiautomation:uia_get_providers_for_hwnd Override provider callback currently unimplemented.
    0120:fixme:uiautomation:msaa_provider_GetPropertyValue Unimplemented propertyId 30024
    Mono path[0] = 'Z:/home/ariel/Games/Heroic/AbsoluteDrift/absolutedrift_Data/Managed'
    Mono config path = 'Z:/home/ariel/Games/Heroic/AbsoluteDrift/absolutedrift_Data/Mono/etc'
    """

    [issues, _] = HeroicSupport.GameLogAnalyzer.analyze_for("linux", content)

    assert Enum.member?(issues, "wineGEDeprecated")
  end
end
