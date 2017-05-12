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
         name: "string",
         description: "string"
     },
     %Primitive{
         name: "integer",
         description: "Uses variable-length encoding. Signed int value.",
         min_value: -9223372036854775808,
         max_value: 9223372036854775807
     },
     %Primitive{
          name: "double",
          description: "floating point value (double)",
          min_value: -9223372036854775808,
          max_value: 9223372036854775807
      },
      %Primitive{
          name: "boolean",
          description: "boolean value (true or false)",
          min_value: 0,
          max_value: 1
      },
      %Primitive{
            name: "bytes",
            description: "bytes"
      },
      %Primitive{
              name: "unsigned_integer",
              description: "Uses variable-length encoding",
              min_value: 0,
              max_value: 18446744073709551615
       }
]

primitives
|> Enum.each(fn (primitive) ->
    Repo.insert! primitive
 end)