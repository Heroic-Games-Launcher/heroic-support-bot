defmodule HeroicSupport.GameLogAnalyzer do
  def load_and_parse(_file_path) do
  end

  def parse(_file_content) do
  end

  # ensure the log has the content of a log
  def sanitize(_file_content) do
  end

  def analyze_links(links) do
    Enum.map(
      links,
      fn link -> [link, analyze(link)] end
    )
  end

  def analyze([_filename, link]) do
    log_content = Req.get!(link).body

    if is_game_log?(log_content) do
      detect_os(log_content) |> analyze_for(log_content) |> Enum.at(0)
    else
      "Not a game log"
    end
  end

  def detect_os(file_content) do
    [[_, os_name]] = Regex.scan(~r/OS:.*\((linux|darwin|win32)\)/, file_content)
    os_name
  end

  def analyze_for("windows", _file_content) do
  end

  def analyze_for("darwin", file_content) do
    [[], file_content]
    |> check_missing_rosetta()
    |> check_gptk_on_intel()
  end

  def analyze_for("linux", file_content) do
    [[], file_content]
    |> check_nvidia_prime()
    |> check_flatpak_update_nvidia()
    |> check_dxvk_driver_version()
    |> check_wine_ge()
  end

  def analyze_for(unknown_os, _file_content) do
    IO.puts("Unknown OS #{unknown_os}, can't analize")

    %{}
  end

  def check_nvidia_prime([issues, file_content]) do
    if Regex.match?(~r/"nvidiaPrime": true/, file_content) do
      [["nvidiaPrimeIsOn" | issues], file_content]
    else
      [issues, file_content]
    end
  end

  def check_missing_rosetta([issues, file_content]) do
    if Regex.match?(~r/Error: spawn Unknown system error -86/, file_content) do
      [["missingRosetta" | issues], file_content]
    else
      [issues, file_content]
    end
  end

  def check_gptk_on_intel([issues, file_content]) do
    if Regex.match?(~r/CPU.*Intel/, file_content) and
         Regex.match?(~r/"name": "Game-Porting-Toolkit/, file_content) do
      [["gptkIncompatibleWithIntel" | issues], file_content]
    else
      [issues, file_content]
    end
  end

  def check_flatpak_update_nvidia([issues, file_content]) do
    if Regex.match?(~r/We are running inside a Flatpak container/, file_content) and
         Regex.match?(~r/Driver: nvidia/, file_content) and
         !Regex.match?(~r/Found device: NVIDIA/, file_content) and
         Regex.match?(~r/Found device: llvmpipe/, file_content) do
      [["flatpakNvidiaOutdated" | issues], file_content]
    else
      [issues, file_content]
    end
  end

  def check_dxvk_driver_version([issues, file_content]) do
    if Regex.match?(~r/Device does not support required feature 'maintenance5'/, file_content) do
      [["DXVKRequiresNewerDriver" | issues], file_content]
    else
      [issues, file_content]
    end
  end

  def check_wine_ge([issues, file_content]) do
    if Regex.match?(~r/"name": "Wine-GE-Proton/, file_content) do
      [["wineGEDeprecated" | issues], file_content]
    else
      [issues, file_content]
    end
  end

  def is_game_log?(log_content) do
    Regex.match?(~r/Launching.*\n.*Native\?.*/, log_content)
  end
end
