import Config

config :nostrum, streamlink: nil, youtubedl: nil, ffmpeg: nil

if config_env() != :prod do
  import_config "#{config_env()}.exs"
end
