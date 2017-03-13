defmodule MongoPoc do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(MongoPoc.Endpoint, []),

      worker(Mongo, [[database: Application.get_env(:mongo_poc, :db)[:name], name: :mongo]])
    ]

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
