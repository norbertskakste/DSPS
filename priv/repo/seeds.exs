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

alias Dsps.Repo
alias Dsps.Primitive

primitives = [
    %Primitive{
        name: "double",
        description: "Double type.",
        min_value: -9_223_372_036_854_775_808,
        max_value: 9_223_372_036_854_775_807
    },
    %Primitive{
        name: "float",
        description: "Float type.",
        min_value: -9_223_372_036_854_775_808,
        max_value: 9_223_372_036_854_775_807
    },
    %Primitive{
        name: "int32",
        description: "Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead.",
        min_value: -2_147_483_648,
        max_value: 2_147_483_647
    },
    %Primitive{
        name: "int64",
        description: "Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead.",
        min_value: -9_223_372_036_854_775_808,
        max_value: 9_223_372_036_854_775_807
    },
    %Primitive{
        name: "uint32",
        description: "Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead.",
        min_value: 0,
        max_value: 4_294_967_295
    },
    %Primitive{
        name: "uint64",
        description: "Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead.",
        min_value: 0,
        max_value: 18_446_744_073_709_551_615
    },
    %Primitive{
        name: "sint32",
        description: "Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s.",
        min_value: -2_147_483_648,
        max_value: 2_147_483_647
    },
    %Primitive{
        name: "sint64",
        description: "Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s.",
        min_value: -9_223_372_036_854_775_808,
        max_value: 9_223_372_036_854_775_807
    },
    %Primitive{
        name: "fixed32",
        description: "Always four bytes. More efficient than uint32 if values are often greater than 2^28.",
        min_value: 0,
        max_value: 4_294_967_295
    },
    %Primitive{
        name: "fixed64",
        description: "Always eight bytes. More efficient than uint64 if values are often greater than 2^56",
        min_value: 0,
        max_value: 18_446_744_073_709_551_615
    },
    %Primitive{
        name: "sfixed32",
        description: "Always four bytes.",
        min_value: -2_147_483_648,
        max_value: 2_147_483_647
    },
    %Primitive{
        name: "sfixed64",
        description: "Always eight bytes.",
        min_value: -9_223_372_036_854_775_808,
        max_value: 9_223_372_036_854_775_807
    },
    %Primitive{
        name: "bool",
        description: "Bool type.",
        min_value: 0,
        max_value: 1
    },
    %Primitive{
        name: "string",
        description: "String type. A string must always contain UTF-8 encoded or 7-bit ASCII text.",
    },
    %Primitive{
        name: "bytes",
        description: "May contain any arbitrary sequence of bytes.",
    },
    %Primitive{
        name: "enum",
        description: "Enum type.",
    },
    %Primitive{
        name: "timestamp",
        description: "Timestamp type.",
    }
]

primitives
|> Enum.each(fn (primitive) ->
    Repo.insert! primitive
 end)