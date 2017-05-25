defmodule Dsps.Repo.Migrations.AddStreamToStreamVariableReference do
  use Ecto.Migration

  def change do
    alter table(:stream_variables) do
      add :stream_id, references(:streams)
    end
  end
end
