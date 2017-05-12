defmodule Dsps.Repo.Migrations.CreateNote do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string
      add :body, :text

      timestamps()
    end

  end
end
