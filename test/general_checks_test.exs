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
end
