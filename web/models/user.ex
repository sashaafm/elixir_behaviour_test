defmodule MongoPoc.User do
  use MongoPoc.Web, :model
  require Logger

  @primary_key {:id, :binary_id, autogenerate: true}  # the id maps to uuid
  schema "users" do
    field :email,  :string
    field :name,   :string
    field :status, :string
  end

  def changeset(user, params \\ %{}) do
    # params = scrub_params(params)  # change "" to nil
    user
    |> cast(params, [:email, :name])
    |> validate_required([:email])
    |> put_change(:status, 1)
  end

end
