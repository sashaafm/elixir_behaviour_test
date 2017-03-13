defmodule MongoPoc.Persistence do
  @type data :: [
    %{
      optional(binary()) => binary(),
      optional(binary()) => binary()
    }
  ]

  @callback write(data :: data()) :: :ok | :error
  @callback read(name :: binary()) :: {:ok, data()} | :error
end
