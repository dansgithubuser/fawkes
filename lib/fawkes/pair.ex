defmodule Fawkes.Pair do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Pair


  schema "pairs" do
    field :key, :string
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(%Pair{} = pair, attrs) do
    pair
    |> cast(attrs, [:key, :value])
    |> validate_required([:key, :value])
  end
end
