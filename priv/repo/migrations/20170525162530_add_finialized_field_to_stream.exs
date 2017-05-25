defmodule Dsps.Repo.Migrations.AddFinializedFieldToStream do
  use Ecto.Migration

  def change do
    alter table(:streams) do
      add :finalized, :bool, null: false, default: false
    end
  end
end
