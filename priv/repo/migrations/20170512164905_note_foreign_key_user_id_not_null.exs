defmodule Dsps.Repo.Migrations.NoteForeignKeyUserIdNotNull do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      remove :user_id
      remove :archived
      remove :global
      remove :level
    end
    alter table(:notes) do
        add :user_id, references(:users), null: false
        add :archived, :boolean, null: false, default: false
        add :global, :boolean, null: false, default: false
        add :level, :integer, null: false, default: 1
    end
  end
end
