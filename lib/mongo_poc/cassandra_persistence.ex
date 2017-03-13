defmodule MongoPoc.CassandraPersistence do
  @behaviour MongoPoc.Persistence

  @conn Application.get_env(:mongo_poc, :cassandra_conn)

  def write(%{"email" => email, "name" => name}) do
    statement = "INSERT INTO users (email, name) VALUES ('#{email}', '#{name}')"

    Xandra.execute(Application.get_env(:mongo_poc, :cassandra_conn), statement, _params = [])
  end
  
  def read(name) do
    conn = Application.get_env(:mongo_poc, :cassandra_conn)
    query    = "SELECT * FROM users WHERE name = ? ALLOW FILTERING"
    {:ok, prepared} = Xandra.prepare(conn, query)

    case Xandra.execute(conn, prepared, [_name = name]) do
      {:ok, result} ->  Enum.map(result, fn res -> res end)
      _ -> :error
    end
  end
end

