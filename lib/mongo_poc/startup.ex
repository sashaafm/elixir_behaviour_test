defmodule MongoPoc.Startup do
  def ensure_indexes do
    IO.puts "Using database #{Application.get_env(:mongo_poc, :db)[:name]}"
    Mongo.command(:mongo, %{createIndexes: "users",
      indexes: [%{key: %{"email": 1}, name: "email_idx", unique: true} ] })
  end
end
