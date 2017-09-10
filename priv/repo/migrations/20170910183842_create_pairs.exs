defmodule Fawkes.Repo.Migrations.CreatePairs do
  use Ecto.Migration

  def change do
    create table(:pairs) do
      add :key, :string
      add :value, :string

      timestamps()
    end

  end
end
