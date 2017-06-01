defmodule Dsps.Repo.Migrations.CreateGraph do
  use Ecto.Migration

  def change do
    create table(:graphs) do
      add :name, :string
      add :stream_id, references(:streams), null: false
      add :stream_variable_id, references(:stream_variables), null: true

      timestamps()
    end

  end
end
