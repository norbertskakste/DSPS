defmodule Dsps.Repo.Migrations.CreateTable do
  use Ecto.Migration

  def change do
    create table(:tables) do
      add :name, :string
      add :stream_id, references(:streams), null: false
      add :stream_variable_ids, {:array, :integer}, null: true
      timestamps()
    end

  end
end
