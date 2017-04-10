defmodule Dsps.Repo.Migrations.AddUniqueIndexNameDatamodel do
  use Ecto.Migration

  def change do
    create unique_index(:datamodels, [:name])
  end

end
