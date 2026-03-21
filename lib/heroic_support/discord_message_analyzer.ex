defmodule HeroicSupport.DiscordMessageAnalyzer do
  def linux_tag, do: 1_022_579_044_610_490_480
  def mac_tag, do: 1_022_579_115_930_419_371

  def analyze_message(msg, channel) do
    [issues, _, _] =
      [[], msg, channel]
      |> check_fortnite_linux_mac()

    issues
  end

  def check_fortnite_linux_mac([results, message, channel]) do
    first_message = message.id == channel.id

    linux_or_mac_tag =
      Enum.member?(channel.applied_tags, linux_tag()) ||
        Enum.member?(channel.applied_tags, mac_tag())

    fortnite_thread =
      Regex.match?(~r/fortnite/, String.downcase(message.content)) ||
        Regex.match?(~r/fortnite/, String.downcase(channel.name))

    if first_message && linux_or_mac_tag && fortnite_thread do
      [["fortniteOnlyWindows" | results], message, channel]
    else
      [results, message, channel]
    end
  end
end
