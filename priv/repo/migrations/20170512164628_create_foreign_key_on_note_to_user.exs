defmodule Dsps.Repo.Migrations.CreateForeignKeyOnNoteToUser do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add :user_id, references(:users)
      add :archived, :boolean
      add :global, :boolean
      add :level, :integer
    end
  end
end
