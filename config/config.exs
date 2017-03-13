# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mongo_poc,
  ecto_repos: [MongoPoc.Repo]

# Configures the endpoint
config :mongo_poc, MongoPoc.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vwuF+qKOKiiVkLF++afFLNmqoMFJlAwAgiY4nAXetPKAd5/mumhQwm5zvMgoeHqX",
  render_errors: [view: MongoPoc.ErrorView, accepts: ~w(json)],
  pubsub: [name: MongoPoc.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :mongo_poc,
  driver: MongoPoc.CassandraPersistence

config :mongo_poc, :db, name: "my-mongo"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true,
  migration: false,
  sample_binary_id: "111111111111111111111111"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
