defmodule MongoPoc do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(MongoPoc.Endpoint, []),

      worker(Mongo, [[database: Application.get_env(:mongo_poc, :db)[:name], name: :mongo]])
    ]

    {:ok, conn} = Xandra.start_link(host: "localhost", port: 9042)
    Xandra.execute! conn, "CREATE keyspace IF NOT EXISTS events_api_test with REPLICATION = {'class': 'SimpleStrategy', 'replication_factor':1}"
    Xandra.execute! conn, "USE events_api_test"
    Xandra.execute! conn, "CREATE TABLE IF NOT EXISTS users (email text PRIMARY KEY, name text)"
    Application.put_env(:mongo_poc, :cassandra_conn, conn)

    opts   = [strategy: :one_for_one, name: MongoPoc.Supervisor]
    result = Supervisor.start_link(children, opts)

    __MODULE__.Startup.ensure_indexes
    result
  end

  def config_change(changed, _new, removed) do
    MongoPoc.Endpoint.config_change(changed, removed)
    :ok
  end
end
