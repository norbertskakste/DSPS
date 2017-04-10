defmodule Dsps.Repo.Migrations.CreateDatamodel do
  use Ecto.Migration

  def change do
    create table(:datamodels) do
      add :name, :string
      add :description, :text
      add :primitive, :boolean, default: false, null: false
      add :struct, :boolean, default: false, null: false

      timestamps()
    end

  end
end
