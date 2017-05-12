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
         description: "integer",
         min_value: -9223372036854775808,
         max_value: 9223372036854775807
     },
     %Primitive{
          name: "float",
          description: "float",
          min_value: -9223372036854775808,
          max_value: 9223372036854775807
      },
      %Primitive{
          name: "boolean",
          description: "boolean",
          min_value: 0,
          max_value: 1
      }
]

primitives
|> Enum.each(fn (primitive) ->
    Repo.insert! primitive
 end)