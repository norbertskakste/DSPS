defmodule Dsps.Repo.Migrations.CreateStream do
  use Ecto.Migration

  def change do
    create table(:streams) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :realtime, :boolean, null: false
      add :enabled, :boolean, null: false
      timestamps()
    end

    create unique_index(:streams, [:name])
  end
end
