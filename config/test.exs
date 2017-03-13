use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mongo_poc, MongoPoc.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :mongo_poc, MongoPoc.Repo,
  adapter: Mongo.Ecto,
  database: "mongo_poc_test",
  pool_size: 1
