# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Mix.Config

# General application configuration
config :garbanzo_beans,
  ecto_repos: [GarbanzoBeans.Repo]

config :phoenix, :json_library, Jason

# Configures the endpoint
config :garbanzo_beans, GarbanzoBeansWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Blu7/Udolspm2Tt0B7FsFgjCdSwwx4sJf4rr5aP0ZNdohRZyh5q43wFmFqP8VWev",
  render_errors: [view: GarbanzoBeansWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: GarbanzoBeans.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
