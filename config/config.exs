# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dsps,
  ecto_repos: [Dsps.Repo]

# Configures the endpoint
config :dsps, Dsps.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XjeVvC8jjsHZy+Z8f4KZ9a1dKyl+/FskVlibAN/H4t60MJE+WQNH8uDVSjQVpzhM",
  render_errors: [view: Dsps.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dsps.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :quantum, :your_app,
  cron: [
    # Every minute
    # "* * * * *": fn -> Dsps.Redis.Session.cleanup end
  ]

config :rummage_phoenix,
  Rummage.Phoenix,
  default_per_page: 5


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
