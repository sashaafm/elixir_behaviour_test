defmodule MongoPoc.UserController do
  use MongoPoc.Web, :controller
  alias MongoPoc.User
  require Logger

  def create(conn, %{"user" => params}) do
    changeset = User.changeset(%User{}, params)
    result    = Mongo.insert_one(:mongo, "users", changeset.changes)
    Logger.info("created a new user #{inspect(result)}")
  end

  def create(conn, %{"user" => params}) do
    changeset = User.changeset(%User{}, params)
    result    = "ol"
  end

  def lookup(conn, %{"email" => email}) do
    cursor = Mongo.find(:mongo, "users", %{"email" => email}, limit: 1)
    list   = Enum.to_list(cursor)

    if length(list) == 1 do
      {:ok, hd(list)}
    else
      {:error, nil}
    end
  end
end
