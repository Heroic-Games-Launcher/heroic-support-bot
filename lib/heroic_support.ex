defmodule HeroicSupport do
  @moduledoc """
  Documentation for `HeroicSupport`.
  """

  def find_links(content) do
    fixed_wrong_links =
      Regex.scan(~r{https://oxo.st/\S+.log}, content) |> Enum.at(0, []) |> fix_links()

    correct_links =
      Regex.scan(~r{https://0x0.st/\S+.log}, content) |> Enum.at(0, []) |> fix_links()

    correct_links ++ fixed_wrong_links
  end

  def find_attachments(attachments) do
    Enum.map(attachments, fn att -> [att.filename, att.url] end)
  end

  def fix_links(links) do
    Enum.map(links, fn link -> String.replace(link, "oxo", "0x0") end)
    |> Enum.map(fn link -> [String.replace(link, "https://0x0.st/", ""), link] end)
  end

  def results_to_message(results) do
    Enum.map(results, fn [[name, _], checks] ->
      "\"#{name}\" analyzed:\n#{Enum.map(checks, fn check -> check_to_string(check) end) |> Enum.join("\n")}"
    end)
    |> Enum.join("\n\n")
  end

  def check_to_string("missingRosetta"),
    do:
      "Rosetta is missing, check https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/wiki/Using-Heroic-on-a-Mac-computer#rosetta"

  def check_to_string("gptkIncompatibleWithIntel"),
    do:
      "Game-Porting-Toolkit is not compatible with Intel mac, use either Wine-Crossover, Wine-Staging, or Crossover. Check https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/wiki/Using-Heroic-on-a-Mac-computer"

  def check_to_string("flatpakNvidiaOutdated"),
    do: "Detected NVIDIA GPU, flatpak, but only software rendering: run `flatpak update`"

  def check_to_string("DXVKRequiresNewerDriver"),
    do:
      "DXVK requires a newer GPU driver version, check https://github.com/doitsujin/dxvk/wiki/Driver-support"

  def check_to_string("nvidiaPrimeIsOn"),
    do:
      "The `Use Dedicated Graphics Card` option is almost never needed. Disable it unless you are completely sure you need it."

  def check_to_string(unknown) do
    unknown
  end
end
