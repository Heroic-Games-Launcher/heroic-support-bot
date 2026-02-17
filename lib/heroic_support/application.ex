defmodule HeroicSupport.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  @spec start(any(), any()) :: {:error, any()} | {:ok, pid()}
  def start(_type, _args) do
    if System.fetch_env!("MIX_ENV") == "test" do
      # See https://hexdocs.pm/elixir/Supervisor.html
      # for other strategies and supported options
      opts = [strategy: :one_for_one, name: HeroicSupport.Supervisor]
      Supervisor.start_link([], opts)
    else
      bot_options = %{
        name: HeroicSupport,
        consumer: HeroicSupport.Consumer,
        intents: [:direct_messages, :guild_messages, :message_content],
        wrapped_token: fn -> System.fetch_env!("BOT_TOKEN") end
      }

      children = [
        {Nostrum.Bot, bot_options}
      ]

      # See https://hexdocs.pm/elixir/Supervisor.html
      # for other strategies and supported options
      opts = [strategy: :one_for_one, name: HeroicSupport.Supervisor]
      Supervisor.start_link(children, opts)
    end
  end
end
