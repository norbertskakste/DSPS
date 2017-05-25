defmodule Dsps.Repo.Migrations.CreateStreamGraph do
  use Ecto.Migration

  def change do
    create table(:stream_graphs) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
