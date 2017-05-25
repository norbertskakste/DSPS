defmodule Dsps.Repo.Migrations.AddUuidToStream do
  use Ecto.Migration

  def change do

    alter table(:streams) do
      add :uuid, :string
    end
  end
end
