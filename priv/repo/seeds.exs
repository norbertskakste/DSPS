# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Dsps.Repo.insert!(%Dsps.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

#Primitive data type creation [datamodels]
defmodule Dsps.Seeds.Datamodels do

    def create_datamodels() do
        types = [:double, :float, :in32, :int64, :uint32, :uint64,
            :sint32, :sint64, :fixed32, :fixed64, :sfixed32,
            :sfixed64, :bool, :string, :bytes]

        default_datamodel_struct = %{
            primitive: true,
            struct: false
        }

        normal_types = types
        |> Enum.map(fn type ->
            default_datamodel_struct
            |> Map.put(:name, Atom.to_string(type))
            |> Map.put(:description, Atom.to_string(type))
            |> Map.put(:repeating, false)
        end)

        repeated_types = types
        |> Enum.map(fn type ->
            default_datamodel_struct
            |> Map.put(:name, Atom.to_string(type))
            |> Map.put(:description, Atom.to_string(type))
            |> Map.put(:repeating, true)
        end)

        normal_types ++ repeated_types
    end

end

Dsps.Seeds.Datamodels.create_datamodels() |> IO.inspect