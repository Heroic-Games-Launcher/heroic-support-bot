defmodule HeroicSupport.Consumer do
  @behaviour Nostrum.Consumer

  alias HeroicSupport.GameLogAnalyzer
  alias Nostrum.Api.Message

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    if !msg.author.bot and forum_message?(msg) do
      links = HeroicSupport.find_links(msg.content)
      attachment_links = HeroicSupport.find_attachments(msg.attachments)
      all_logs = links ++ attachment_links

      if !Enum.empty?(all_logs) do
        result = GameLogAnalyzer.analyze_links(all_logs)

        Message.create(
          msg.channel_id,
          "[This is an automatic message, don't reply to the bot 🤖]\n\n#{HeroicSupport.results_to_message(result)}"
        )
      else
        if msg.id == msg.channel_id do
          Message.create(
            msg.channel_id,
            "[This is an automatic message, don't reply to the bot 🤖]\n\nNo log links or attachments detected. Make sure to read https://discord.com/channels/812703221789097985/1044301598018515105."
          )
        end
      end
    end
  end

  # Ignore any other events
  def handle_event(_), do: :ok

  defp forum_message?(message) do
    with {:ok, channel} <- get_channel(message.channel_id),
         {:ok, parent} <- get_channel(channel.parent_id) do
      # 15 is the GUILD_FORUM type https://docs.discord.com/developers/resources/channel#channel-object-channel-types
      parent.type == 15
    else
      _ -> false
    end
  end

  defp get_channel(channel_id) do
    case Nostrum.Cache.GuildCache.get(channel_id) do
      {:ok, channel} ->
        {:ok, channel}

      _ ->
        Nostrum.Api.Channel.get(channel_id)
    end
  end
end
