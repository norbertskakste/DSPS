defmodule Dsps.Repo.Migrations.AddRepeatingColumnToDatamodels do
  use Ecto.Migration

  def change do
    alter table(:datamodels) do
      add :repeating, :boolean, default: false, null: false
    end
  end
end
