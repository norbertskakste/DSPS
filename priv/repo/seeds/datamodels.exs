defmodule Dsps.Seeds.Datamodels do

    @moduledoc """
    Seeds the database with primitive Protobuf types
    """

    @doc """
    Generates datamodels (normal and repeating)
    """
    defp create_datamodels() do
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
            |> Map.put(:name, Atom.to_string(type) <> "_repeating")
            |> Map.put(:description, Atom.to_string(type))
            |> Map.put(:repeating, true)
        end)

        normal_types ++ repeated_types
    end

    @doc """
    Generates and insert datamodels into database
    """
    def insert_datamodels() do
        create_datamodels()
        |> Enum.each(fn datamodel ->
            changeset = Dsps.Datamodel.changeset(%Dsps.Datamodel{}, datamodel)

            Dsps.Repo.insert_or_update(changeset, on_conflict: :nothing)
        end)
    end

end