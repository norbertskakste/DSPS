defmodule Dsps.Repo.Migrations.AddNullChecksToStreamVariablesAddFinishedFieldToStream do
    use Ecto.Migration

    def change do
    alter table(:streams) do
        add :finished, :boolean, null: false, default: false
    end

    alter table(:stream_variables) do
        remove :primitive_id
        remove :stream_id
    end

    drop table(:stream_variables)

    create table(:stream_variables) do
        add :name, :string, null: false
        add :comment, :string, null: false

        add :stream_id, references(:streams), null: false
        add :primitive_id, references(:primitives), null: false
        timestamps()
    end
    end
end
