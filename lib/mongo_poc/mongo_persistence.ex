defmodule MongoPoc.MongoPersistence do
  @behaviour MongoPoc.Persistence

  def write(%{"email" => email, "name" => name}) do
    case Mongo.insert_one :mongo, "users", %{"email" => email, "name" => name} do
      {:ok, _} -> :ok
      _ -> :error
    end
  end

  def read(name) do
    result =Mongo.find(:mongo, "users", %{"name" => name})
    |> Enum.to_list

    case result do
      [] -> :error
      result -> result
    end
  end
end
