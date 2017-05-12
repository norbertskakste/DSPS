defmodule Dsps.Repo.Migrations.StreamPrimitiveBigintToNumeric do
  use Ecto.Migration

  def change do
    alter table(:primitives) do
        modify :max_value, :numeric, null: true
        modify :min_value, :numeric, null: true
        modify :max_length, :numeric, null: true
        modify :min_length, :numeric, null: true
    end
  end
end
