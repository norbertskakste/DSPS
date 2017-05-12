defmodule Dsps.Repo.Migrations.AddStreamPrimitivesTable do
  use Ecto.Migration

  def change do
    create table(:primitives) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :max_value, :bigint, null: true
      add :min_value, :bigint, null: true
      add :max_length, :bigint, null: true
      add :min_length, :bigint, null: true

      timestamps()
    end

    create unique_index(:primitives, [:name])
  end
end
