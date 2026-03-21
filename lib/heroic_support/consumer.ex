defmodule HeroicSupport.Consumer do
  @behaviour Nostrum.Consumer

  alias HeroicSupport.GameLogAnalyzer
  alias HeroicSupport.DiscordMessageAnalyzer
  alias Nostrum.Api.Message

  # message sample
  # %Nostrum.Struct.Message{
  #   activity: nil,
  #   application: nil,
  #   application_id: nil,
  #   attachments: [],
  #   author: %Nostrum.Struct.User{
  #     id: 1234,
  #     username: "asd",
  #     discriminator: "0",
  #     global_name: "asd",
  #     avatar: "123",
  #     bot: nil,
  #     public_flags: 0
  #   },
  #   channel_id: 123,
  #   content: "testttttt",
  #   components: [],
  #   edited_timestamp: nil,
  #   embeds: [],
  #   id: 123,
  #   interaction: nil,
  #   guild_id: 123,
  #   member: %Nostrum.Struct.Guild.Member{
  #     avatar: nil,
  #     communication_disabled_until: nil,
  #     deaf: false,
  #     flags: 123,
  #     joined_at: 123,
  #     mute: false,
  #     nick: nil,
  #     pending: false,
  #     premium_since: nil,
  #     roles: [123],
  #     user_id: nil
  #   },
  #   mention_everyone: false,
  #   mention_roles: [],
  #   mention_channels: nil,
  #   mentions: [],
  #   message_reference: nil,
  #   nonce: nil,
  #   pinned: false,
  #   poll: nil,
  #   reactions: nil,
  #   referenced_message: nil,
  #   sticker_items: nil,
  #   timestamp: ~U[2026-03-21 13:52:47.671000Z],
  #   thread: nil,
  #   tts: false,
  #   type: 0,
  #   webhook_id: nil
  # }

  # Channel sample
  # %Nostrum.Struct.Channel{
  #   id: 123,
  #   type: 11,
  #   guild_id: 123,
  #   position: nil,
  #   permission_overwrites: nil,
  #   name: "testing the bot",
  #   topic: nil,
  #   nsfw: nil,
  #   last_message_id: 123,
  #   bitrate: 64000,
  #   user_limit: 0,
  #   rate_limit_per_user: 0,
  #   recipients: nil,
  #   icon: nil,
  #   owner_id: 123,
  #   application_id: nil,
  #   parent_id: 123,
  #   last_pin_timestamp: nil,
  #   rtc_region: nil,
  #   video_quality_mode: nil,
  #   message_count: 0,
  #   member_count: 1,
  #   thread_metadata: %{
  #     locked: false,
  #     archive_timestamp: ~U[2026-03-21 14:22:48.292000Z],
  #     create_timestamp: ~U[2026-03-21 14:22:48.292000Z],
  #     archived: false,
  #     auto_archive_duration: 4320
  #   },
  #   member: nil,
  #   default_auto_archive_duration: nil,
  #   permissions: nil,
  #   newly_created: nil,
  #   available_tags: nil,
  #   applied_tags: [1022579044610490480, 1022579115930419371],
  #   default_reaction_emoji: nil,
  #   default_thread_rate_limit_per_user: nil,
  #   default_sort_order: nil,
  #   default_forum_layout: nil
  # }

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    if !msg.author.bot and forum_message?(msg) do
      links = HeroicSupport.find_links(msg.content)
      attachment_links = HeroicSupport.find_attachments(msg.attachments)
      all_logs = links ++ attachment_links

      # analyze links and attachments
      if !Enum.empty?(all_logs) do
        result = GameLogAnalyzer.analyze_links(all_logs)

        result_string = HeroicSupport.results_to_message(result)

        if result_string != "" do
          Message.create(
            msg.channel_id,
            "[This is an automatic message, don't reply to the bot 🤖]\n\n#{result_string}"
          )
        end
      else
        if msg.id == msg.channel_id do
          Message.create(
            msg.channel_id,
            "[This is an automatic message, don't reply to the bot 🤖]\n\nNo log links or attachments detected. Make sure to read https://discord.com/channels/812703221789097985/1044301598018515105."
          )
        end
      end

      # analyze message text and thread data
      {:ok, channel} = get_channel(msg.channel_id)
      message_result = DiscordMessageAnalyzer.analyze_message(msg, channel)

      if !Enum.empty?(message_result) do
        result_string = HeroicSupport.content_results_to_message(message_result)

        if result_string != "" do
          Message.create(
            msg.channel_id,
            "[This is an automatic message, don't reply to the bot 🤖]\n\n#{result_string}"
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
      # 1042545607849541662 is the id of the `💡-suggestions` section
      parent.type == 15 and channel.parent_id != 1_042_545_607_849_541_662
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
