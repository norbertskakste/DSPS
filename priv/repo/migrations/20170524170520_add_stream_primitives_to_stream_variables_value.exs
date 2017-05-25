defmodule Dsps.Repo.Migrations.AddStreamPrimitivesToStreamVariablesValue do
    use Ecto.Migration

    def change do
        alter table(:stream_variables) do
            add :primitive_id, references(:primitives)
        end
    end
end
