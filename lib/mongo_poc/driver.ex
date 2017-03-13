defmodule MongoPoc.Driver do
  @behaviour MongoPoc.Persistence

  @driver Application.get_env(:mongo_poc, :driver)

  defdelegate write(data), to: @driver, as: :write
  defdelegate read(name), to: @driver, as: :read
end
