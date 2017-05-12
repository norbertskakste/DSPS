defmodule Dsps.Repo.Migrations.CreateStreamVariable do
  use Ecto.Migration

  def change do
    create table(:stream_variables) do
      add :name, :string, null: false
      add :comment, :string, null: false
      timestamps()
    end

  end
end
